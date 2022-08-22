{-
  Copyright (c) Meta Platforms, Inc. and affiliates.
  All rights reserved.

  This source code is licensed under the BSD-style license found in the
  LICENSE file in the root directory of this source tree.
-}

{-# LANGUAGE ApplicativeDo #-}
{-# LANGUAGE TypeApplications #-}

module Glean.Glass.Annotations
  ( getAnnotationsForEntity
  ) where


import Data.Text (Text)
import Data.Maybe (catMaybes)

import Glean.Angle as Angle
import qualified Glean.Haxl.Repos as Glean
import qualified Glean.Schema.Codemarkup.Types as Code
import qualified Glean.Schema.Code.Types as Code
import qualified Glean.Schema.CodeCxx.Types as Cxx1
import qualified Glean.Schema.CodeHack.Types as Hack
import qualified Glean.Schema.Cxx1.Types as Cxx1
import qualified Glean.Schema.Hack.Types as Hack

import Glean.Glass.SymbolId (entityToAngle)
import Glean.Glass.Pretty.Annotations
import qualified Glean.Glass.Types as Glass
import Glean.Glass.Utils ( searchRecursiveWithLimit )

-- | For Hack, the annotations are a single fact.
-- For C++ they're sprinkled across each function decl, forcing us to search
max_annotations_limit :: Int
max_annotations_limit = 10

getAnnotationsForEntity
  :: Code.Entity
  -> Glean.RepoHaxl u w (Either Text (Maybe [Glass.Annotation]))
getAnnotationsForEntity entity = fetch `mapM` entityToAngle entity
  where
    fetch ent = getAnnotations <$> queryAnnotations ent

queryAnnotations
  :: Angle Code.Entity -> Glean.RepoHaxl u w [Code.EntityToAnnotations]
queryAnnotations entity = searchRecursiveWithLimit (Just max_annotations_limit)$
  Angle.predicate @Code.EntityToAnnotations $
    rec $
      field @"entity" entity
    end

class HasAnnotations a where
  getAnnotations :: a -> Maybe [Glass.Annotation]

instance HasAnnotations a => HasAnnotations [a] where
  getAnnotations [] = Nothing
  getAnnotations anns = Just $ concat $ catMaybes $ getAnnotations <$> anns

instance HasAnnotations Code.EntityToAnnotations where
  getAnnotations ann = Code.entityToAnnotations_key ann
    >>= getAnnotations . Code.entityToAnnotations_key_annotations

instance HasAnnotations [Code.Annotations] where
  getAnnotations anns = Just $ concat $ catMaybes $ getAnnotations <$> anns

instance HasAnnotations Code.Annotations where
  getAnnotations (Code.Annotations_cxx ann) = getAnnotations ann
  getAnnotations (Code.Annotations_hack ann) = getAnnotations ann
  getAnnotations Code.Annotations_python{} = Nothing -- Not yet supported
  getAnnotations Code.Annotations_thrift{} = Nothing -- Not yet supported
  getAnnotations Code.Annotations_java{} = Nothing -- Not yet supported
  getAnnotations Code.Annotations_EMPTY = Nothing

instance HasAnnotations Cxx1.Annotations where
  getAnnotations (Cxx1.Annotations_attributes anns) = getAnnotations anns
  getAnnotations Cxx1.Annotations_EMPTY = Nothing

instance HasAnnotations Cxx1.Attribute where
  getAnnotations Cxx1.Attribute{attribute_key=Just key} = Just
    [ Glass.Annotation
        { annotation_source = prettyCxxAnnotation key
        , annotation_name = key
        , annotation_symbol = Nothing
        }
    ]
  getAnnotations _ = Nothing

instance HasAnnotations Hack.Annotations where
  getAnnotations (Hack.Annotations_attributes anns) = getAnnotations anns
  getAnnotations Hack.Annotations_EMPTY = Nothing

instance HasAnnotations Hack.UserAttribute where
  getAnnotations
    Hack.UserAttribute
      {
        userAttribute_key = Just Hack.UserAttribute_key
          {
            userAttribute_key_name=Hack.Name{name_key=Just name}
          , userAttribute_key_parameters=args
          }
      } = Just
          [ Glass.Annotation
              { annotation_source = prettyHackAnnotation name args
              , annotation_name = name
              , annotation_symbol = Nothing
              }
          ]
  getAnnotations _ = Nothing
