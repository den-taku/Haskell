module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    print "someFunc"
    print $ inc (2*3)
    print $ split [1,2,3,4]
    print $ split [1,2,3,4,5]
    print $ split [3]
    print $ mult (1+2) (2+3)
    print $ (\_ -> 1 + 2) 0
    print $ fst (0,inf)

inc :: Int -> Int
inc = (+) 1

split :: [a] -> ([a], [a])
split [] = ([],[])
split [x] = ([x], [])
split (x:y:zs) = (x:xs,y:ys) where (xs,ys) = split zs

-- mult :: (Int,Int) -> Int
-- mult (x,y) = x*y

mult :: Int -> Int -> Int
mult x = \y -> x * y

inf :: Int
inf = 1 + inf

square :: Int -> Int
square n = n * n