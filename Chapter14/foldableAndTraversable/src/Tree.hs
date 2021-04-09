module Tree
    (someFunc
    ) where

import Data.Foldable

someFunc :: IO ()
someFunc = do
    print "Tree"
    print $ filterF even (Node (Leaf) 3 (Node (Leaf) 4 (Node (Leaf) 6 (Leaf))))

data Tree a = Leaf | Node (Tree a) a (Tree a)
    deriving Show

instance Foldable Tree where
    -- foldMap :: Monoid b => (a -> b) -> Tree a -> b
    foldMap f Leaf         = mempty
    foldMap f (Node l v r) = foldMap f l `mappend` f v `mappend` foldMap f r

instance Functor Tree where
    -- fmap :: (a -> b) -> Tree a -> Tree b
    fmap f Leaf         = Leaf
    fmap f (Node l v r) = (Node (fmap f l) (f v) (fmap f r))

instance Traversable Tree where
    -- traverse :: Applicative f => (a -> f b) -> Tree a -> f (Tree b)
    traverse g Leaf         = pure Leaf
    traverse g (Node l v r) = pure Node <*> traverse g l <*> g v <*> traverse g r

filterF :: Foldable t => (a -> Bool) -> t a -> [a]
filterF f = foldMap g where g x = if f x then [x] else []