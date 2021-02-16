module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    print $ find "1" [("1", 1), ("2", 2), ("3", 3)]

-- type String = [Char]

type Pos a = (a, a)

type Trans a = Pos a -> Pos a

type Assoc k v = [(k,v)]

find :: Eq k => k -> Assoc k v -> v
find k t = head [v | (k',v) <- t, k == k']
