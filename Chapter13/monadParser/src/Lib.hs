module Lib
    ( someFunc
    ) where

import Control.Applicative
import Data.Char

someFunc :: IO ()
someFunc = do
    print $ parse item ""
    print $ parse item "abc"
    print $ parse (fmap toUpper item) "abc"
    print $ parse (fmap toUpper item) ""
    return ()

newtype Parser a = P (String -> [(a,String)])

instance Functor Parser where
    -- fmap :: (a -> b) -> Parser a -> Parser b
    fmap g p = P (\inp -> case parse p inp of
        []        -> []
        [(v,out)] -> [(g v, out)])

parse :: Parser a -> String -> [(a, String)]
-- parse (P p) inp = p inp
parse (P p) = p

item :: Parser Char
item = P (\inp -> case inp of
    []     -> []
    (x:xs) -> [(x,xs)])