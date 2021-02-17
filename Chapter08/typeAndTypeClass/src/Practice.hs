module Practice
    (someFunc
    ) where

someFunc :: IO ()
someFunc = do 
    print $ "Practice"
    print $ nat2int $ mult (int2nat 9) (int2nat 8)
    print $ mult (int2nat 90) Zero
    print $ countLeaf tree
    print $ balanced tree

data Nat = Zero | Succ Nat deriving Show

nat2int :: Nat -> Int
nat2int Zero     = 0
nat2int (Succ n) = 1 + nat2int n

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))

add :: Nat -> Nat -> Nat
add Zero     n = n
add (Succ m) n = Succ (add m n)

mult :: Nat -> Nat -> Nat
mult Zero     n = Zero
mult (Succ m) n = n `add` mult m n 

data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Show

tree :: Tree Int
tree = Node (Node (Leaf 7) (Node (Leaf 1) (Leaf 3))) (Node (Leaf 9) (Leaf 8))

countLeaf :: Tree a -> Int
countLeaf (Leaf _)   = 1
countLeaf (Node l r) = countLeaf l + countLeaf r

balanced :: Tree a -> Bool
balanced (Leaf _)   = True
balanced (Node l r) = abs (countLeaf l - countLeaf r) <= 1 && balanced l && balanced r  
