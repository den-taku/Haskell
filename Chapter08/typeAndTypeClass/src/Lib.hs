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
    print $ int2nat 8
    print $ add (Succ (Succ Zero)) (Succ (Succ (Succ Zero)))
    print $ t
    print $ occers 3 t
    print $ occers 4567 t
    print $ flattern t

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

-- newtype Nat = N Int deriving Show

data Nat = Zero | Succ Nat deriving Show

nat2int :: Nat -> Int
nat2int Zero     = 0
nat2int (Succ n) = 1 + nat2int n

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))

-- add :: Nat -> Nat -> Nat
-- add m n = int2nat $ nat2int m + nat2int n

add :: Nat -> Nat -> Nat
add Zero     n = n
add (Succ m) n = Succ (add m n)

data List a = Nill | Cons a (List a) deriving Show

len :: List a -> Int
len Nill        = 0
len (Cons _ xs) = 1 + len xs

data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving Show

t :: Tree Int
t = Node (Node (Leaf 1) 3 (Leaf 4)) 5
         (Node (Leaf 6) 7 (Leaf 9))

-- occers :: Eq a => a -> Tree a -> Bool
-- occers x (Leaf y)     = x == y
-- occers x (Node l y r) = x == y || occers x l || occers x r

flattern :: Tree a -> [a]
flattern (Leaf x)     = [x] 
flattern (Node l x r) = flattern l ++ [x] ++ flattern r

occers :: Ord a => a -> Tree a -> Bool
occers x (Leaf y)                 = x == y
occers x (Node l y r) | x == y    = True
                      | x < y     = occers x l
                      | otherwise = occers x r