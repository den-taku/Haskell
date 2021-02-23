module Main where

import Cpu
import System.IO

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    play empty O
