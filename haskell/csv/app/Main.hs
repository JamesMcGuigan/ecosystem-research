module Main where

import Lib
import Text.CSV

main :: IO ()
main = do
  let input_csv_filename  = "./data/input.csv"
  let output_csv_filename = "./data/output.csv"

  Lib.reverseCSVFile input_csv_filename output_csv_filename
  Lib.printFile input_csv_filename
