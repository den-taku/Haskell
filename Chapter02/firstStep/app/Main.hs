module Main where

import Lib

main :: IO ()
main = do
    print $ head [1, 2, 3, 4, 5]
    print $ tail [1, 2, 3, 4, 5]
    print $ [1, 2, 3, 4, 5] !!  2
    print $ take 3 [1, 2, 3, 4, 5]
    print $ drop 3 [1, 2, 3, 4, 5]
    print $ length [1, 2, 3, 4, 5]
    print $ sum [1, 2, 3, 4, 5]
    print $ product [1, 2, 3, 4, 5]
    print $ [1, 2, 3] ++ [4, 5]
    print $ reverse [1, 2, 3, 4, 5]
    print $ quadruple 10
    print $ take (double 2) [1, 2, 3, 4, 5]
    print $ factorial 10
    print $ average [1, 2, 3, 4, 5]
    print $ my_last [1, 2, 3, 4, 5]
    print $ my_init1 [1, 2, 3, 4, 5]
    print $ my_init2 [1, 2, 3, 4, 5]
