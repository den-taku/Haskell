module Lib
    ( someFunc, halve, luhn
    ) where

someFunc :: IO ()
someFunc = putStrLn "Hello, World!"

even :: Integral a => a -> Bool
even n = n `mod` 2 == 0

splitAt :: Int -> [a] -> ([a], [a])
splitAt n xs = (take n xs, drop n xs)

recip :: Fractional a => a -> a
recip n = 1/n

abs :: Int -> Int
-- abs n = if n >= 0 then n else -n
abs n | n >= 0    = n
      | otherwise = -n

signum :: Int -> Int 
-- signum n = if n < 0 then -1 else 
    -- if n == 0 then 0 else 1
signum n | n < 0     = -1
         | n == 0    = 0
         | otherwise = 1

not :: Bool -> Bool
not False = True
not True = False

(&&) :: Bool -> Bool -> Bool
-- True && True   = True
-- True && False  = False
-- False && True  = False
-- False && False = False
-- _    && _      = False
True  && b = b
False && _ = False

fst (x,_) = x
snd (_,y) = y

test ('a':_) = True
test _       = False

add :: Int -> Int -> Int
add = \x -> \y -> x + y

const :: a -> (b -> a)
const x = \_ -> x

-- odds :: Int -> [Int]
-- odds n = map f [0..n-1]
--          where f x = x * 2 + 1

odds :: Int -> [Int]
odds n = map (\x -> x * 2 + 1) [0..n-1]

halve :: [a] -> ([a], [a])
halve xs = (take (length xs `div` 2) xs, drop (length xs `div` 2) xs)

tese xs = length xs `div` 2

mult :: Int -> Int -> Int -> Int
mult = \x -> \y -> \z -> x * y * z

luhnDouble :: Int -> Int
luhnDouble n | n >= 5 = n + n - 9
             | n >= 0 = n + n

-- my_sum :: Num a => [a] -> a
-- my_sum []   = 0
-- my_sum (x:xs) = x + my_sum xs

luhn :: Int -> Int -> Int -> Int -> Bool
luhn = \x -> \y -> \z -> \w -> sum [luhnDouble x, y, luhnDouble z, w] `mod` 10 == 0