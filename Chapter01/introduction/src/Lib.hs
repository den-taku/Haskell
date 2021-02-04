module Lib
    ( someFunc, double, qsort, seqn, my_product, qsort2, my_sum
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

double x = x + x

my_sum []     = 0
my_sum (n:ns) = n + my_sum ns

qsort []     = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
               where
                   smaller = [a | a <- xs, a <= x]
                   larger  = [b | b <- xs, b > x]

qsort2 []     = []
qsort2 (x:xs) = qsort2 larger ++ [x] ++ qsort2 smaller
               where
                   smaller = [a | a <- xs, a <= x]
                   larger  = [b | b <- xs, b > x]

seqn :: Monad m => [m a] -> m [a]
seqn []         = return []
seqn (act:acts) = do x <- act 
                     xs <- seqn acts
                     return (x:xs)

my_product []     = 1
my_product (x:xs) = x * my_product xs