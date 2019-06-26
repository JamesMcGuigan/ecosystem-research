module Lib (
  printFile,
  filenameToIOString
) where

printFile :: String -> IO ()
printFile fileName = do
 input <- readFile fileName
 putStrLn input

filenameToIOString :: String -> IO String
filenameToIOString fileName = do
  input <- readFile fileName
  return input