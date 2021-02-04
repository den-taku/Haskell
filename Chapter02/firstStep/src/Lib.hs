module Lib
    ( someFunc, double, quadruple, factorial, average, 
      my_last, my_init1, my_init2
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

double x = x + x
quadruple x = double (double x)

-- Factorial of a positive integer
factorial n = product [1..n]

-- Average of a list of integers
average ns = sum ns `div` length ns

my_last xs = xs !! (length xs - 1)

my_init1 xs = take (length xs - 1) xs
my_init2 xs = reverse (tail (reverse xs))
