module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    print $ find "1" [("1", 1), ("2", 2), ("3", 3)]
    print $ moves [North, South, South, West] (0,0)
    print $ rev North
    print $ Rect 9.0 8.0
    print $ area $ square 5.0
    print $ area $ Circle 9.0
    print $ safediv 8 0
    print $ safehead [1..10]

-- type String = [Char]

type Pos = (Int, Int)

type Trans = Pos -> Pos 

type Assoc k v = [(k,v)]

find :: Eq k => k -> Assoc k v -> v
find k t = head [v | (k',v) <- t, k == k']

-- data Bool = False | True

data Move = North | South | East | West deriving Show

move :: Move -> Pos -> Pos
move North (x,y) = (x,y+1)
move South (x,y) = (x,y-1)
move East  (x,y) = (x+1,y)
move West  (x,y) = (x-1,y)

moves :: [Move] -> Pos -> Pos
moves []     p = p
moves (m:ms) p = moves ms (move m p)

rev :: Move -> Move
rev North = South
rev South = North
rev East  = West
rev West  = East

data Shape = Circle Float | Rect Float Float deriving Show

square :: Float -> Shape
square n = Rect n n

area :: Shape -> Float
area (Circle r) = pi * r^2
area (Rect x y) = x * y

safediv :: Int -> Int -> Maybe Int
safediv _ 0 = Nothing
safediv x y = Just $ x `div` y

safehead :: [a] -> Maybe a
safehead [] = Nothing
safehead xs = Just $ head xs

newtype Nat = N Int deriving Show