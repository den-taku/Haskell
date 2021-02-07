module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- y_conb x y z = x y $ x z
fix g = g (fix g)

-- hoge = \x -> \y -> \z -> x y (x z)