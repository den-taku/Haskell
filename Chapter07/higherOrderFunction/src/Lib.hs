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
    print $ Lib.foldr1 (+) 0 [1..10]
    print $ foldr (\_ n -> 1+n) 0 [1..1000]
    print $ reverse1 [1..10]
    print $ sum2 [1..10]
    print $ foldl (*) 1 [1..10]
    print $ foldl (&&) True [True, True, True, True]
    print $ Lib.foldl1 (\n _ -> n+1) 0 [1..9000]
    print $ (not . even) 5
    print $ ((+1) . (+1)) 7
    print $ (sum . Lib.map (^2) . Lib.filter even) [1..20]
    print $ compose [(+1), (+2), (+3)] 7

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

sum1 :: Num a => [a] -> a
sum1 = foldr (+) 0

product1 :: Num a => [a] -> a
product1 = foldr (*) 1

or1 :: [Bool] -> Bool
or1 = foldr (||) False

and1 :: [Bool] -> Bool
and1 = foldr (&&) True

foldr1 :: (a -> b -> b) -> b -> [a] -> b
foldr1 f v []     = v
foldr1 f v (x:xs) = f x (Lib.foldr1 f v xs)

reverse1 :: [a] -> [a]
reverse1 = foldr snoc []
            where
                snoc x xs = xs ++ [x]

sum2 :: Num a => [a] -> a
sum2 = sum' 0
       where
           sum' v []     = v
           sum' v (x:xs) = sum' (v+x) xs

foldl1 :: (a -> b -> a) -> a -> [b] -> a
foldl1 f v []     = v 
foldl1 f v (x:xs) = Lib.foldl1 f (f v x) xs

-- (.) :: (b -> c) -> (a -> b) -> (a -> c)
-- f . g = \x -> f (g x)

compose :: [a -> a] -> (a -> a)
compose = foldr (.) id