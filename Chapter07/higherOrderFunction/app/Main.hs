module Main where

import Lib
import StBi
import Vote

main :: IO ()
main = do
    Lib.someFunc
    StBi.printTest
    Vote.printTest
    print $ trans $ zip [1..] ["a", "b", "c"]
    print $ mapBool ["a", "b", "c"]
    print $ altMap (+10) (+100) [0..4]

trans :: [(Int, a)] -> [(Bool, a)]
trans [] = []
trans (x:xs) = case x of
                   (n, x) -> (odd n, x) : trans xs

mapBool :: [a] -> [(Bool, a)]
mapBool = (trans . zip [1..])

mapFunc :: (a -> b) -> (a -> b) -> [(Bool, a)] -> [b]
mapFunc f g []     = [] 
mapFunc f g (x:xs) = case x of
                         (True, x) -> f x : mapFunc f g xs
                         (_, x)    -> g x : mapFunc f g xs

altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap = \f g -> mapFunc f g . mapBool


-- altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
-- altMap f g xs = (map apply . map trans . zip [1..]) xs
--                 where 
--                     apply :: [(Bool, a)] -> [b]
--                     apply []     = []
--                     apply (t:ts) = case t of
--                         (True, x)  -> f x : ts
--                         (False, y) -> g y : ts 
--                     trans :: [(Int, a)] -> [(Bool, a)]
--                     trans t = case t of
--                         (n, x) -> (odd n, x)
