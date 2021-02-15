module Vote
    ( printTest
    ) where

import Data.List

printTest :: IO ()
printTest = do 
    print "Hello, world!"
    print $ count "Red" votes
    print $ rmdups votes
    print $ result votes
    print $ winner votes

votes :: [String]
votes = ["Red", "Blue", "Green", "Blue", "Blue", "Red"]

count :: Eq a => a -> [a] -> Int
count x = length . filter (==x)

rmdups :: Eq a => [a] -> [a]
rmdups []     = []
rmdups (x:xs) = x : rmdups (filter (/= x) xs)

result :: Ord a => [a] -> [(Int, a)]
result vs = sort [(count v vs, v) | v <- rmdups vs]

winner :: Ord a => [a] -> a
winner = snd . last . result