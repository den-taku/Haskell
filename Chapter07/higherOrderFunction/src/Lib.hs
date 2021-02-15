module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    print $ msort [3, 3, 532, 3, 32, 3, 63, 7, 312, 4, 7, 1, 32, 4]
    print $ twice (*2) 3
    print $ twice reverse [1, 2, 3]
    print $ Lib.map (+1) [1, 3, 5, 7]
    print $ Lib.map even [1, 2, 3, 4]
    print $ Lib.map reverse ["abc", "def", "ghi"]
    print $ Lib.map (Lib.map (+1)) [[1, 2, 3], [4, 5]]
    print $ map2 (map2 (map2 (+1))) [[[1, 2, 3], [2, 3, 4]], [[3, 4, 5]], [[3], [4], [5]]]
    print $ Lib.filter even [1..10]
    print $ Lib.filter (>5) [1..10]
    print $ Lib.filter (/= ' ') "abc def ghi"
    print $ filter2 odd [1..10]
    print $ sumsqreven [1..20]
    print $ all even [2, 4, 6, 8]
    print $ any odd [2, 4, 6, 8]
    print $ takeWhile even [2, 4, 6, 7, 8]
    print $ dropWhile odd [1, 3, 5, 6, 7]

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

add :: Int -> (Int -> Int)
add = \x -> \y -> x + y

twice :: (a -> a) -> a -> a
twice f x = f (f x)

map :: (a -> b) -> [a] -> [b]
map f xs = [f x | x <- xs]

map2 :: (a -> b) -> [a] -> [b]
map2 f []     = []
map2 f (x:xs) = f x : map2 f xs 

filter :: (a -> Bool) -> [a] -> [a]
filter p xs = [x | x <- xs, p x]

filter2 :: (a -> Bool) -> [a] -> [a]
filter2 p []                 = []
filter2 p (x:xs) | p x       = x : filter2 p xs
                 | otherwise = filter2 p xs 

sumsqreven :: [Int] -> Int
sumsqreven ns = sum $ Lib.map (^2) $ Lib.filter even ns