module Parser
    ( parse, expr, someFunc
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
    print $ parse nats " [1, 2, 3] "
    print $ parse nats " [1, 2, ] "
    print $ eval "2*3+4"
    print $ eval "2*(3+4)"
    print $ eval "2-(3*4)"
    print $ eval "5*4+6/3"
    -- print $ eval "2*3^4"
    -- print $ eval "one plus two"
    print $ parse comment "-- hogehnohge\n345"
    print $ eval "3^2^2"
    print $ eval "3^(4-2)"
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

token :: Parser a -> Parser a
token p = do
    space
    v <- p
    space
    return v

identifier :: Parser String
identifier = token ident

natural :: Parser Int
natural = token nat

integer :: Parser Int
integer = token int

symbol :: String -> Parser String
symbol xs = token (string xs)

nats :: Parser [Int]
nats = do
    symbol "["
    n <- natural
    ns <- many (do
        symbol ","
        natural)
    symbol "]"
    return (n:ns)

expr :: Parser Int
expr = do
    t <- term 
    do
        symbol "+"
        e <- expr
        return (t + e)
     <|> do
        symbol "-"
        e <- expr
        return (t - e)
     <|> return t

term :: Parser Int
term = do
    ex <- expo
    do
        symbol "*"
        t <- term
        return (ex * t)
     <|> do
         symbol "/"
         e <- term
         return (ex `div` e)
     <|> return ex

expo :: Parser Int
expo = do
    f <- factor
    do
        symbol "^"
        e <- expo
        return (f ^ e)
     <|> return f

factor :: Parser Int
factor = do
    symbol "("
    e <- expr
    symbol ")"
    return e
  <|> natural

eval :: String -> Int
eval xs = case (parse expr xs) of
    [(n,[])]  -> n
    [(_,out)] -> error ("Unused input " ++ out)
    []        -> error "Invalid input"

comment :: Parser ()
comment = do
    symbol "--"
    many item
    symbol "\n"
    return ()