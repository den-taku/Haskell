module Main where

import Lib

main :: IO ()
main = do
    someFunc
    print $ (+) 3 2
    print $ halve [1, 2, 3, 4, 5, 6]
    print $ luhn 1 7 8 4
    print $ luhn 4 7 8 3
