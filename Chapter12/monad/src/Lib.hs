module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    putStrLn "someFunc"
    print $ hoge 8

hoge = fuga 

fuga n = n