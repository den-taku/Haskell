module Lib
    ( someFunc
    ) where

import Data.Typeable
import Data.Monoid
import Data.Foldable

someFunc :: IO ()
someFunc = do
    let unit = print "Lib!"
    print $ typeOf unit
    print $ mconcat [Sum 2, Sum 3, Sum 4]
    print $ getSum $ mconcat [Sum 2, Sum 3, Sum 4]
    print $ mconcat [Product 2, Product 3, Product 4]
    print $ getProduct $ mconcat [Product 2, Product 3, Product 4]
    print $ mconcat [All True, All True, All True]
    print $ getAll $ mconcat [All True, All True, All True]
    print $ mconcat [Any False, Any False, Any False]
    print $ getAny $ mconcat [Any False, Any False, Any False]
    print $ getAll $ All True <> All True <> All True
    print $ [1, 2, 3] `mappend` [3, 4] `mappend` mempty `mappend` []
    print $ fold [All True, All True, All True, All False]
    print $ Lib.foldMap' id [All True, All True, All True, All False]
    print $ getSum (foldMap Sum [1..10])
    print $ getProduct (foldMap Product [1..10])
    print $ foldr (+) 1 tree - 1
    print $ foldl (+) 1 tree - 1
    print $ null []
    print $ null (Leaf 1)
    print $ length [1..10]
    print $ length (Node (Leaf 'a') (Leaf 'b'))
    print $ length (Leaf 1)
    print $ foldr1 (+) [1..10]
    print $ foldl1 (+) (Node (Leaf 1) (Leaf 2))
    print $ sum (Node (Leaf 1) (Leaf 3))
    print $ toList tree
    print $ average [1..10]
    print $ average (Node (Leaf 1) (Leaf 3))
    print $ and (Node (Leaf True) (Leaf True))
    print $ or (Node (Node (Leaf False) (Leaf False)) (Node (Node (Leaf True) (Leaf False)) (Leaf False)))
    print $ any even tree
    print $ traverse dec [1,2,3]
    print $ traverse dec [2,1,0]
    print $ traverse' dec [1,2,3]
    print $ traverse dec [2,1,0]
    print $ traverse dec (Node (Leaf 1) (Leaf 2))
    print $ traverse dec (Node (Leaf 0) (Leaf 1))


-- fold :: Monoid a => [a] -> a
-- fold []     = mempty
-- fold (x:xs) = x `mappend` fold xs

data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Show

-- foldt :: Monoid a => Tree a -> a
-- foldt (Leaf x)   = x
-- foldt (Node l r) = fold l `mappend` fold r

class Foldable' t where
       fold'    :: Monoid a => t a -> a
       foldMap' :: Monoid b => (a -> b) -> t a -> b
       foldr'   :: (a -> b -> b) -> b -> t a -> b
       foldl'   :: (a -> b -> a) -> a -> t b -> a

instance Foldable' [] where
    -- fold :: Monoid a => [a] -> a
    fold' []     = mempty
    fold' (x:xs) = x `mappend` Lib.fold' xs

    -- foldMap :: Monoid b => (a -> b) -> [a] -> b
    foldMap' _ []     = mempty
    foldMap' f (x:xs) = f x `mappend` Lib.foldMap' f xs

    -- foldr :: (a -> b -> b) -> b -> [a] -> b
    foldr' _ v []     = v
    foldr' f v (x:xs) = f x (Lib.foldr' f v xs)

    -- foldl :: (a -> b -> a) -> a -> [b] -> a
    foldl' _ v []     = v
    foldl' f v (x:xs) = Lib.foldl' f (f v x) xs

instance Foldable Tree where
    -- fold :: Monoid a => Tree a -> a
    -- fold (Leaf x)   = x
    -- fold (Node l r) = fold l `mappend` fold r 

    -- foldMap :: Monoid b => (a -> b) -> Tree a -> b
    foldMap f (Leaf x)   = f x
    foldMap f (Node l r) = foldMap f l `mappend` foldMap f r

    -- foldr :: (a -> b -> b) -> b -> Tree a -> b
    -- foldr f v (Leaf x)   = f x v
    -- foldr f v (Node l r) = foldr f (foldr f v r) l

    -- foldl :: (a -> b -> b) -> a -> Tree b -> a
    -- foldl f v (Leaf x)   = f v x
    -- foldl f v (Node l r) = foldl f (foldl f v l) r

tree :: Tree Int
tree = Node (Node (Leaf 1) (Leaf 2)) (Leaf 3)

average :: Foldable t => t Int -> Int
average ns = sum ns `div` length ns

-- traverse :: (a -> Maybe b) -> [a] -> Maybe [b]
-- traverse g []     = pure []
-- traverse g (x:xs) = pure (:) <*> g x <*> Lib.traverse g xs

dec :: Int -> Maybe Int
dec n = if n > 0 then Just (n-1) else Nothing

class (Functor t, Foldable t) => Traversable' t where
    traverse' :: Applicative f => (a -> f b) -> t a -> f (t b)

instance Traversable' [] where
    -- traverse' :: Applicative f => (a -> f b) -> [a] -> f [b]
    traverse' g []     = pure []
    traverse' g (x:xs) = pure (:) <*> g x <*> traverse' g xs

instance Functor Tree where
    -- fmap :: (a -> b) -> Tree a -> Tree b
    fmap g (Leaf x)   = Leaf (g x)
    fmap g (Node l r) = Node (fmap g l) (fmap g r)

instance Traversable Tree where
    -- traverse :: Applicative f => (a -> f b) -> Tree a -> f (Tree b)
    traverse g (Leaf x)   = pure Leaf <*> g x
    traverse g (Node l r) = pure Node <*> traverse g l <*> traverse g r