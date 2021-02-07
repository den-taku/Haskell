module Main where

import Lib

main :: IO ()
main = do
    -- print $ False :: Bool
    -- print $ not False :: Bool
    -- print $ not (not False) :: Bool
    print $ add (2, 3)
    print $ zeroto 7
    print $ mult 45 78 34
    let n = 3 :: Num a => a 
    print $ n + 9
    print $ n + 8.0
