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
    print $ parse (pure 1) "abc"
    print $ parse three "abcdef"
    print $ parse three "ab"
    print $ parse (empty :: Parser Char) "abc"
    print $ parse (item <|> return 'd') "abc"
    print $ parse ((P (\inp -> [])) <|> return 'd') "abc"
    print $ parse (char 'a') "abc"
    print $ parse (string "abc") "abcdef"
    print $ parse (string "abc") "ab1234"
    print $ parse (many digit) "123abc"
    print $ parse (many digit) "abc"
    print $ parse (some digit) "abc"
    print $ parse ident "abc def"
    print $ parse nat "123 abc"
    print $ parse space "   abc"
    print $ parse int "-123 abc"  
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

instance Applicative Parser where
    -- pure :: a -> Parser a
    pure v = P (\inp -> [(v, inp)])

    -- <*> :: Parser (a -> b) -> Parser a -> Parser b
    pg <*> px = P (\inp -> case parse pg inp of
        []        -> []
        [(g,out)] -> parse (fmap g px) out)

-- three :: Parser (Char, Char)
-- three = pure g <*> item <*> item <*> item
--     where g x y z = (x,z)

instance Monad Parser where
    -- (>>=) :: Parser a -> (a -> Parser b) -> Parser b
    p >>= f = P (\inp -> case parse p inp of
        []        -> []
        [(v,out)] -> parse (f v) out)

three :: Parser (Char, Char)
three = do 
    x <- item
    item
    z <- item
    return (x,z)

instance Alternative Parser where
    -- empty :: Parser a
    empty = P (\inp -> [])

    -- (<|>) :: Parser a -> Parser a -> Parser a
    p <|> q = P (\inp -> case parse p inp of
        []        -> parse q inp
        [(v,out)] -> [(v,out)])

sat :: (Char -> Bool) -> Parser Char
sat p = do 
    x <- item
    if p x then return x else empty

digit :: Parser Char
digit = sat isDigit

lower :: Parser Char
lower = sat isLower

upper :: Parser Char
upper = sat isUpper

letter :: Parser Char
letter = sat isAlpha

alphanum :: Parser Char
alphanum = sat isAlphaNum

char :: Char -> Parser Char
char x = sat (== x)

string :: String -> Parser String
string []     = return []
string (x:xs) = do
    char x
    string xs
    return (x:xs)

ident :: Parser String
ident = do
    x <- lower
    xs <- many alphanum
    return (x:xs)

nat :: Parser Int
nat = do
    xs <- some digit
    return (read xs)

space :: Parser ()
space = do
    many (sat isSpace)
    return ()

int :: Parser Int
int = do
    char '-'
    n <- nat
    return (-n)
  <|> nat