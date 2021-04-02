module Main where

import Cal
import System.IO

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    run

-- main :: IO ()
-- main = someFunc
