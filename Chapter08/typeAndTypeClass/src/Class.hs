module Class
    (someFunc
    ) where

someFunc :: IO ()
someFunc = do
    print "Class"
    let f = read "False" :: Bool
    print $ f
    print $ "Hoge"

-- data Boolean = F | T deriving Show

-- class Eq a where
--     (==), (/=) :: a -> a -> Bool
--     x /= y = not (x Class.== y)

-- instance Class.Eq Boolean where
--     F == F = T
--     T == T = T
--     _ == _ = F

-- class Eq a => Ord a where
--     (<), (<=), (>), (>=) :: a -> a -> Bool
--     min, max             :: a -> a -> a

--     min x y | x <= y    = x
--             | otherwise = y

--     max x y | x <= y    = y
--             | otherwise = x

-- instance Ord Bool where
--     False < True = True
--     _     < _    = False

--     b <= c = (b < c) || (b == c)
--     b > c  = c < b
--     b >= c = c <= b