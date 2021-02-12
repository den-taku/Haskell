module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    print $ msort [3, 3, 532, 3, 32, 3, 63, 7, 312, 4, 7, 1, 32, 4]

msort :: Ord a => [a] -> [a]
msort []  = []
msort [x] = [x]  
msort xs  = merge (msort as) (msort bs)
            where
                merge :: Ord a => [a] -> [a] -> [a]
                merge []     ys     = ys
                merge xs     []     = xs 
                merge (x:xs) (y:ys) | x >= y    = y : merge (x:xs) ys
                                    | otherwise = x : merge xs (y:ys)
                (as, bs) = halve xs
                    where
                        halve :: [a] -> ([a], [a])
                        halve xs = (take n xs, drop n xs)
                                   where
                                       n = (length xs) `div` 2 