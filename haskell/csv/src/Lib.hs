{-# LANGUAGE OverloadedStrings #-}
module Lib (
  printFile,
  filenameToIOString,
  reverseCSVColumns,
  reverseCSVFile,
) where

import Data.Conduit
import Data.Conduit.Binary
import Data.Conduit.List as CL
import Data.CSV.Conduit
import Data.Text (Text)


printFile :: String -> IO ()
printFile fileName = do
  fileContents <- filenameToIOString fileName
  putStrLn (fileName ++ fileContents)

filenameToIOString :: String -> IO String
filenameToIOString fileName = do
  input <- readFile fileName
  return input

-- DOCS: http://hackage.haskell.org/package/csv-conduit
-- NOTE: reverses order of columns, but not data rows
reverseCSVColumns :: Monad m => Conduit (Row Text) m (Row Text)
reverseCSVColumns = CL.map reverse
-- reverseCSVColumns = awaitForever $ yield

-- Let's simply stream from a file, parse the CSV, reserialize it
-- and push back into another file.
-- reverseCSVFile :: FilePath FilePath -> Monad m()
reverseCSVFile input_csv_filename output_csv_filename = do
  runResourceT $
    sourceFile input_csv_filename 
      $= intoCSV defCSVSettings 
      $= reverseCSVColumns 
      $= fromCSV defCSVSettings 
      $$ sinkFile output_csv_filename  