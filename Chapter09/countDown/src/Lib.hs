module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    print "Hello, world"

data Op = Add | Sub | Mul | Div

instance Show Op where
    show Add = "+"
    show Sub = "-"
    show Mul = "*"
    show Div = "/"