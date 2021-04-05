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


-- fold :: Monoid a => [a] -> a
-- fold []     = mempty
-- fold (x:xs) = x `mappend` fold xs

-- data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Show

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

