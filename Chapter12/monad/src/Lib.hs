module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    putStrLn "someFunc"
    -- print $ take 7 $ iterate id 3
    print $ fmap' (+1) Nothing
    print $ fmap' (*2) (Just 3)
    print $ fmap' not (Just False)
    print $ fmap length (Leaf "abc")
    print $ fmap even (Node (Leaf 1) (Leaf 2))
    fmap' show (return True)
    print $ inc' (Just 1)
    print $ inc' [1, 2, 3, 4, 5]
    print $ inc (Node (Leaf 1) (Leaf 2))
    print $ (\x -> x * x) $ 7
    print (($) (\x -> x * x) 7)
    print $ pure' (+1) <**> Just 1
    print $ pure' (+) <**> Just 1 <**> Just 2
    print $ pure' (+) <**> Nothing <**> Just 2
    print $ pure (+1) <*> Just 1
    print $ pure (+) <*> Nothing <*> Just 2
    print $ pure (+1) <**> [1, 2, 3]
    print $ pure (*) <*> [1, 2] <*> [3, 4]
    print $ sequenceA [Just 3, Just 4, Just 5]
    print $ sequenceA [Just 3, Nothing, Just 4, Just 5]
    print $ sequenceA [[3, 4], [5, 6], [7, 8], [9]]
    print $ sequenceA [[3, 4], [5, 6], [7, 8], [], [9]]
    print $ (\x y z -> x + y * z) <$> Just 4 <*> Just 5 <*> Just 6
    print $ (+1) <$> [1, 2, 3, 4]
    print $ (<$>) (+1) [1, 2, 3, 4]

-- inc :: [Int] -> [Int]
-- inc []     = []
-- inc (n:ns) = n+1 : inc ns
inc' :: Functor' f => f Int -> f Int
inc' = fmap' (+1)

inc :: Functor f => f Int -> f Int
inc = fmap (+1)

-- sqr :: [Int] -> [Int]
-- sqr []     = []
-- sqr (n:ns) = n^2 : sqr ns
sqr = map (^2)

-- map :: (a -> b) -> [a] -> [b]
-- map f []     = []
-- map f (x:xs) = f x : Lib.map f xs

class Functor' f where
    fmap' :: (a -> b) -> f a -> f b

instance Functor' [] where
    -- fmap :: (a -> b) -> [a] -> [b]
    fmap' = map

instance Functor' Maybe where
    -- fmap :: (a -> b) -> Maybe a -> Maybe b
    fmap' _ Nothing = Nothing
    fmap' g (Just x) = Just (g x)

data Tree a = Leaf a | Node (Tree a) (Tree a)
              deriving Show

instance Functor Tree where
    -- fmap :: (a -> b) -> Tree a -> Tree b
    fmap g (Leaf x)   = Leaf (g x)
    fmap g (Node l r) = Node (fmap g l) (fmap g r)

instance Functor' IO where
    -- fmap' :: (a -> b) -> IO a -> IO b
    fmap' g mx = do {x <- mx; return (g x)}

class Functor f => Applicative' f where
    pure' :: a -> f a
    (<**>) :: f (a -> b) -> f a -> f b

instance Applicative' Maybe where
    -- pure' :: a -> Maybe a
    pure' = Just

    -- <**> :: Maybe (a -> b) -> Maybe a -> Maybe b
    Nothing <**> _ = Nothing
    (Just g) <**> mx = fmap g mx

instance Applicative' [] where
    pure' x = [x]
    gs <**> xs = [g x | g <- gs, x <- xs]

prods :: [Int] -> [Int] -> [Int]
-- prods xs ys = [x*y | x <- xs, y <- ys]
prods xs ys = pure (*) <*> xs <*> ys

instance Applicative' IO where
    -- pure' :: a -> IO a
    pure' = return

    -- (<**>) :: IO (a -> b) -> IO a -> IO b
    mg <**> mx = do {g <- mg; x <- mx; return (g x)}

getChars :: Int -> IO String
getChars 0 = return []
getChars n = pure (:) <*> getChar <*> getChars (n-1)
    
sequenceA' :: Applicative f => [f a] -> f [a]
sequenceA' []     = pure [] 
sequenceA' (x:xs) = pure (:) <*> x <*> sequenceA' xs

getChars' :: Int -> IO String
getChars' n = sequenceA (replicate n getChar)