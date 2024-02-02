{-
  Copyright (c) Meta Platforms, Inc. and affiliates.
  All rights reserved.

  This source code is licensed under the BSD-style license found in the
  LICENSE file in the root directory of this source tree.
-}

{-# LANGUAGE TypeApplications #-}
module Derive.Common
  ( getFileXRefs
  , getFileXRefsFor
  , getIndirectTargets
  , resolve
  , Indirects
  , XRefs
  ) where

import Control.Exception
import Control.Monad
import Data.HashSet (HashSet)
import qualified Data.HashSet as HashSet
import Data.Maybe
import qualified Data.Vector as V
import qualified Data.Vector.Mutable as VM

import Util.List
import Util.Log

import Glean
import Glean.Angle
import qualified Glean.Schema.Cxx1.Types as Cxx
import Glean.Util.PredMap (PredMap)
import qualified Glean.Util.PredMap as PredMap
import Glean.Util.PredSet (PredSet)
import qualified Glean.Util.PredSet as PredSet

import Derive.Types

-- | Keys are xRefIndirectTarget_id, values are xRefIndirectTarget_key_target
-- Note: XRefTarget_indirect constructor does not appear in these values
type Indirects = PredMap Cxx.XRefIndirectTarget Cxx.XRefTarget

-- Keys are fileXRefMap_id, values are sets of targets for each external target
-- in the map.
type XRefs =
  PredMap
    Cxx.FileXRefMap
    (PredSet Cxx.FileXRefs, V.Vector (HashSet Cxx.XRefTarget))

type MutableXRefs =
  PredMap
    Cxx.FileXRefMap
    (PredSet Cxx.FileXRefs, VM.IOVector (HashSet Cxx.XRefTarget))

getIndirectTargets
  :: Backend e => e -> Config -> IO Indirects
getIndirectTargets e cfg = do

  let q = maybe id limit (cfgMaxQueryFacts cfg) $
        limitBytes (cfgMaxQuerySize cfg) allFacts

  -- Build indirect map that is 1-level deep.  Chains of indirections not
  -- yet resolved so the values may be XRefTarget_indirect.
  targets <- runQueryEach e (cfgRepo cfg) q mempty $ \targets fact -> do
    return $ PredMap.insert
      (getId fact)
      (Cxx.xRefIndirectTarget_key_target $ fromJust $ getFactKey fact)
      targets

  let -- Use 'targets' to resolve chains of indirections to resolve
      -- (or remove) all XRefTarget_indirect constructors.
      squash (Cxx.XRefTarget_indirect x)
        | Just next <- PredMap.lookup (getId x) targets = squash next
        | otherwise = Nothing -- shouldn't happen
      squash x = Just x

  return $ PredMap.mapMaybe squash targets

-- | The result never has XRefTarget_indirect constructor
resolve :: Indirects -> Cxx.XRefTarget -> Maybe Cxx.XRefTarget
resolve indirects (Cxx.XRefTarget_indirect x) =
  PredMap.lookup (getId x) indirects
resolve _ x = Just x

getFileXRefs :: Backend e => e -> Config -> IO XRefs
getFileXRefs e cfg = do
  -- Collect all of the `XRefTargets` facts first rather than expanding them.
  -- Since there's a lot of sharing of these facts, the cache hit rate is high.
  targetsMap <- do
    let q :: Query Cxx.XRefTargets
        q = maybe id limit (cfgMaxQueryFacts cfg) $
            limitBytes (cfgMaxQuerySize cfg) allFacts
    runQueryEach e (cfgRepo cfg) q mempty
        $ \targetsMap (Cxx.XRefTargets i k) -> do
      key <- case k of
        Just k -> return k
        Nothing -> throwIO $ ErrorCall "internal error: getFileXRefs"
      return $ PredMap.insert (IdOf $ Fid i) (HashSet.fromList key) targetsMap
  logInfo $ "loaded " ++ show (PredMap.size targetsMap) ++ " XRefTargets"

  let
    q :: Query Cxx.FileXRefs
    q = maybe id limit (cfgMaxQueryFacts cfg) $
        limitBytes (cfgMaxQuerySize cfg) allFacts

  xrefs <- runQueryEach e (cfgRepo cfg) q mempty
      $ \xrefs (Cxx.FileXRefs i k) -> do
    key <- case k of
      Just k -> return k
      Nothing -> throwIO $ ErrorCall "internal error: getFileXRefs"
    let targets =
          [ PredMap.findWithDefault
              (error "missing XRefTargets") (getId targets) targetsMap
          | targets <- Cxx.fileXRefs_key_targets key ]
        id = getId (Cxx.fileXRefs_key_xmap key)
    case PredMap.lookup id xrefs of
      Just (deps, xs) -> do
        forM_ (zip [0 .. VM.length xs - 1] targets) $ \(i, ts) -> do
          x <- VM.unsafeRead xs i
          VM.unsafeWrite xs i $! HashSet.union ts x
        let !newDeps = PredSet.insert (IdOf $ Fid i) deps
        return $ PredMap.insert id (newDeps, xs) xrefs
      Nothing -> do
        xs <- VM.new (length targets)
        forM_ (zip [0..] targets) $ \(i, ts) ->
          VM.unsafeWrite xs i $! ts
        return $ PredMap.insert id (PredSet.singleton (IdOf $ Fid i), xs) xrefs
  traverse (\(deps, xs) -> (deps,) <$> V.unsafeFreeze xs) xrefs

getFileXRefsFor
  :: Backend e
  => e
  -> [IdOf Cxx.FileXRefMap]
  -> Config
  -> IO XRefs
getFileXRefsFor _ [] _ = return PredMap.empty
getFileXRefsFor e xmapIds cfg = do
  let
    q :: Query Cxx.FileXRefs
    q = limitBytes (cfgMaxQuerySize cfg) $ query $
          vars $ \(xmap :: Angle Cxx.FileXRefMap) xrefs ->
            xrefs `where_` [
              xmap .= elementsOf (factIdsArray xmapIds),
              xrefs .= (predicate @Cxx.FileXRefs $ rec $
                field @"xmap" (asPredicate xmap) end)
            ]

  (_, xrefs) <- runQueryEachBatch e (cfgRepo cfg) q (mempty, mempty)
    withFileXRefs
  traverse (\(deps, xs) -> (deps,) <$> V.unsafeFreeze xs) xrefs

  where
  withFileXRefs
    :: (PredMap Cxx.XRefTargets (HashSet Cxx.XRefTarget), MutableXRefs)
    -> [Cxx.FileXRefs]
    -> IO (PredMap Cxx.XRefTargets (HashSet Cxx.XRefTarget), MutableXRefs)
  withFileXRefs (oldTargetMap, xrefs) fileXRefs = do
    let
      newTargetIds = uniq
          [ t
          | Cxx.FileXRefs _ (Just (Cxx.FileXRefs_key _ targets)) <- fileXRefs
          , t <- map getId targets
          , not (t `PredMap.member` oldTargetMap)
          ]

      q2 :: Query Cxx.XRefTargets
      q2 = maybe id limit (cfgMaxQueryFacts cfg) $
          limitBytes (cfgMaxQuerySize cfg) $ query $
            elementsOf (factIdsArray newTargetIds)

    newTargets <- runQuery_ e (cfgRepo cfg) q2
    let newTargetMap = PredMap.fromList
          [ (IdOf $ Fid i, HashSet.fromList k)
          | Cxx.XRefTargets i (Just k) <- newTargets
          ]
        targetMap = PredMap.union newTargetMap oldTargetMap

    let
      add xrefs (Cxx.FileXRefs i (Just (Cxx.FileXRefs_key xmap targetIds))) = do
        let !id = getId xmap
            targets = [ key | t <- targetIds,
              Just key <- [PredMap.lookup (getId t) targetMap]]
        case PredMap.lookup id xrefs of
          Just (deps, xs) -> do
            forM_ (zip [0 .. VM.length xs - 1] targets) $ \(i, ts) -> do
              x <- VM.unsafeRead xs i
              VM.unsafeWrite xs i $! HashSet.union ts x
            let !newDeps = PredSet.insert (IdOf $ Fid i) deps
            return $ PredMap.insert id (newDeps, xs) xrefs
          Nothing -> do
            xs <- VM.new (length targets)
            forM_ (zip [0..] targets) $ \(i, ts) ->
              VM.unsafeWrite xs i ts
            return $
              PredMap.insert id (PredSet.singleton (IdOf $ Fid i), xs) xrefs
      add xrefs _ = return xrefs

    newXrefs <- foldM add xrefs fileXRefs
    return (targetMap, newXrefs)
