module Main where

import Lib

main :: IO ()
main = do 
    print $ double 4
    print $ double $ double 3
    print $ sum [1..9]
    print $ my_sum [1..9]
    print $ qsort [3, 5, 1, 4, 2]
    print $ qsort "Hello, world!"
    print $ my_product [2, 3, 4]
    print $ qsort2 [3, 5, 1, 4, 2]
    -- let str = seqn [getChar, getChar, getChar]
    -- print str
