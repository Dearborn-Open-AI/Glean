{-
  Copyright (c) Meta Platforms, Inc. and affiliates.
  All rights reserved.

  This source code is licensed under the BSD-style license found in the
  LICENSE file in the root directory of this source tree.
-}

--
-- Utility to convert .scip files to Glean JSON for indexing, acting as an
-- external indexer binary
--
{-# LANGUAGE ApplicativeDo #-}
module Glean.Indexer.SCIP.Main ( main ) where

import qualified Data.Text as Text
import Options.Applicative
import Control.Monad
import Glean.Init (withOptions)
import System.Directory (doesFileExist)
import Glean.SCIP.Driver as SCIP
import qualified Glean.LSIF.Driver as Util

data SCIP = SCIP
  { scipFile :: FilePath -- ^ input file
  , outputFile :: FilePath -- ^ output file
  , scipLanguage :: Maybe LanguageId -- ^ a default language if known
  }

options :: Parser SCIP
options = do
  scipFile <- option str $ long "input" <>
    metavar "PATH" <>
    help "Path to a specific SCIP file to convert"
  outputFile <- option str $ long "output"
    <> metavar "PATH"
    <> help "Output filepath to write encoded schema info"
  scipLanguage <- option (Just <$> readLanguage) $ long "language" <>
    metavar "LANGUAGE" <>
    value Nothing <>
    help "Default language of files in the index"
  return SCIP{..}

-- If the indexer doesn't set the langauge Id of the files, we
-- can assert it here. Otherwise Glean won't know what language the
-- symbols are in
readLanguage ::  ReadM LanguageId
readLanguage = do
  ln <- Text.toLower <$> str
  case ln of
    "typescript" -> return TypeScript
    "rust" -> return Rust
    "go" -> return Go
    _ -> readerError "Unrecognized SCIP language (see codemarkup.types.angle)"

main :: IO ()
main = withOptions (info (helper <*> options) fullDesc) $ \SCIP{..} -> do
  scipExists <- doesFileExist scipFile
  when (not scipExists) $ error ("Could not find SCIP file at: " <> scipFile)
  json <- SCIP.processSCIP scipLanguage scipFile
  Util.writeJSON outputFile json
