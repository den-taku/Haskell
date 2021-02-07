module Lib
    ( add, zeroto, mult
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- y_conb x y z = x y $ x z
fix g = g (fix g)

-- hoge = \x -> \y -> \z -> x y (x z)

foo 0 = "Zero"
foo 1 = "One"
foo 2 = "Two"

add :: (Int, Int) -> Int
add (x, y) = x + y

zeroto :: Int -> [Int]
zeroto n = [0..n]

mult :: Int -> (Int -> (Int -> Int))
mult x y z = x * y * z