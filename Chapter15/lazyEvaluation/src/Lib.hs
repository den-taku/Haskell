module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    print "someFunc"
    print $ inc (2*3)

inc :: Int -> Int
inc = (+) 1