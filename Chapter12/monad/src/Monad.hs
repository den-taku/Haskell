module Monad
    (someFunc
    ) where

someFunc :: IO () 
someFunc = do
    print "Monad"
    print $ eval (Div (Val 1) (Val 0))
    print $ pairs [1, 2] [3, 4]
    print $ do {x <- return 4; y <- return 6; safediv x y}
    print $ do {x <- return 4; y <- return 0; safediv x y}
    return ()

data Expr = Val Int | Div Expr Expr

-- eval :: Expr -> Int
-- eval (Val n)   = n 
-- eval (Div x y) = eval x `div` eval y

safediv :: Int -> Int -> Maybe Int
safediv _ 0 = Nothing
safediv n m = Just (n `div` m)

-- eval :: Expr -> Maybe Int
-- eval (Val n)   = Just n
-- eval (Div x y) = case eval x of 
--     Nothing -> Nothing
--     Just n -> case eval y of
--         Nothing -> Nothing
--         Just m -> safediv n m

-- eval :: Expr -> Maybe Int
-- eval (Val n)   = pure n
-- eval (Div x y) = pure safediv <*> eval x <*> eval y

-- (>>==) :: Maybe a -> (a -> Maybe b) -> Maybe b
-- mx >>== f = case mx of
--     Nothing -> Nothing
--     Just x  -> f x

-- eval :: Expr -> Maybe Int
-- eval (Val n)   = Just n
-- eval (Div x y) = eval x >>== \n -> eval y >>== \m -> safediv n m

eval :: Expr -> Maybe Int
eval (Val n)   = Just n
eval (Div x y) = do n <- eval x
                    m <- eval y
                    safediv n m 

class Applicative m => Monad' m where
    return' :: a -> m a
    (>>==) :: m a -> (a -> m b) -> m b

    return' = pure 

instance Monad' Maybe where
    -- (>>==) :: Maybe a -> (a -> Maybe b) -> Maybe b
    Nothing >>== _  = Nothing
    (Just x) >>== f = f x

instance Monad' [] where
    -- (>>==) :: [a] -> (a -> [b]) -> [b]
    xs >>== f = [y | x <- xs, y <- f x]

pairs :: [a] -> [b] -> [(a, b)]
pairs xs ys = do x <- xs
                 y <- ys
                 return (x, y)

type State = Int
newtype ST a = S (State -> (a, State))

app :: ST a -> State -> (a, State)
app (S st) x = st x

instance Functor ST where
    -- fmap :: (a -> b) -> ST a -> ST b
    fmap g st = S (\s -> let (x,s') = app st s in (g x, s'))

instance Applicative ST where
    -- pure :: a -> ST a
    pure x = S (\s -> (x,s))

    -- <*> :: ST (a -> b) -> ST a -> ST b
    stf <*> stx = S (\s ->
        let (f,s')  = app stf s
            (x,s'') = app stx s' in (f x, s''))

instance Monad ST where
    -- (>>=) :: ST a -> (a -> ST b) -> ST b
    st >>= f = S (\s -> let (x,s') = app st s in app (f x) s')