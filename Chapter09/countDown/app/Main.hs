module Main where

import Lib

main :: IO ()
main = do
    someFunc
    print $ remove 2 [1..10]
    print $ remove 1001 [1..1000]
    print $ isChoice [1, 4, 6, 7] [1..10]
    print $ isChoice [1, 3, 5, 7, 9] [1..8]

remove :: Eq a => a -> [a] -> ([a], Bool)
remove _ []     = ([], False)
remove n (x:xs) | n == x    = (xs, True)
                | otherwise = (x : ys, yb) where (ys, yb) = remove n xs

isChoice :: Eq a => [a] -> [a] -> Bool
isChoice []     _  = True
isChoice (x:xs) ys = zb && isChoice xs zs where (zs, zb) = remove x ys
