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

inc :: Int -> Int
inc = (+) 1

split :: [a] -> ([a], [a])
split [] = ([],[])
split [x] = ([x], [])
split (x:y:zs) = (x:xs,y:ys) where (xs,ys) = split zs