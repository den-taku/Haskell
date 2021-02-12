module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do 
    print $ fac 9
    print $ 6 Lib.* 9
    print $ Lib.product [2, 3, 4]
    print $ Lib.reverse [1, 2, 3]
    print $ insert 3 [1, 2, 3, 4, 5]
    print $ isort [3,2,5,3,5,6,34,6,3,2,42,5,64,2,1,23,4,6,45,32]
    print $ Lib.zip ['a', 'b', 'c'] [1, 2, 3, 4]
    print $ fib 8
    print $ qsort [3,2,5,3,5,6,34,6,3,2,42,5,64,2,1,23,4,6,45,32]
    print $ Lib.even 89
    print $ evens "Hello, my name is DenTaku!"

fac :: Int -> Int
fac 0 = 1
fac n = n Prelude.* fac (n-1)

(*) :: Int -> Int -> Int
m * 0 = 0
m * n = m + (m Lib.* (n - 1))

product :: Num a => [a] -> a
product [] = 1
product (n:ns) = n Prelude.* Lib.product ns 

reverse :: [a] -> [a]
reverse [] = []
reverse (x:xs) = Lib.reverse xs ++ [x]

insert :: Ord a => a -> [a] -> [a]
insert x []                 = [x]
insert x (y:ys) | x <= y    = x : y : ys
                | otherwise = y : insert x ys

isort :: Ord a => [a] -> [a]
isort []     = []
isort (x:xs) = insert x (isort xs)

zip :: [a] -> [b] -> [(a, b)]
zip []     _      = []
zip _      []     = []
zip (x:xs) (y:ys) = (x,y) : Lib.zip xs ys

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-2) + fib (n-1)

qsort :: Ord a => [a] -> [a]
qsort []     = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger 
               where
                   smaller = [a | a <- xs, a <= x]
                   larger = [b | b <- xs, b > x] 

even :: Int -> Bool
even 0 = True
even n = Lib.odd (n-1)

odd :: Int -> Bool
odd 0 = False
odd n = Lib.even (n-1)

evens :: [a] -> [a]
evens [] = []
evens  (x:xs) = x : odds xs

odds :: [a] -> [a]
odds [] = []
odds (_:xs) = evens xs
