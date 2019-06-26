module Main where

import Lib
import Text.CSV

main :: IO ()
main = do
  let fileName = "./data/input.csv"
  Lib.printFile fileName
  fileContents <- Lib.filenameToIOString fileName
  putStrLn (fileName ++ fileContents)
