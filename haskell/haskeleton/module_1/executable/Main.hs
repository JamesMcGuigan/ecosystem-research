{-# LANGUAGE OverloadedStrings #-}
-- DOCS: http://hackage.haskell.org/package/csv-conduit

import Data.Conduit
import Data.Conduit.Binary
import Data.CSV.Conduit
import Data.Text (Text)

import qualified StockAnalysis

main :: IO ()
main = do
myProcessor :: Monad m => Conduit (Row Text) m (Row Text)
myProcessor = awaitForever $ yield

-- Let's simply stream from a file, parse the CSV, reserialize it
-- and push back into another file.
main :: IO ()
main = runResourceT $ 
  let input_csv_filename  = "../data/stocks/Mid_Cap/MUTHOOTFIN.csv"
  let output_csv_filename = "../data/output/week2-haskell.csv"  
  sourceFile input_csv_filename $= 
  intoCSV defCSVSettings $=
  myProcessor $=
  fromCSV defCSVSettings $$
  sinkFile output_csv_filename