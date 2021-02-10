module Main where

import Lib

main :: IO ()
main = do
    someFunc
    print [x^2 | x <- [1..5]]
    print [(x, y) | x <- [1, 2, 3], y <- [4, 5]]
    print [(x, y) | x <- [1..3], y <- [x..3]]
    print $ firsts [(1, 2), (4, 5), (6, 7), (1, 9)]
    print $ factors 36
    print $ prime 2345692673
    print $ find 'b' [('a', 1), ('b', 2), ('c', 3), ('b', 4)]
    print $ sorted [1, 2, 3, 4]
    print $ sorted [1, 3, 2, 4]
    print $ positions False [True, False, True, False]
    print $ "abcde" !! 2
    print $ zip "This is a pen." [0..]
    print $ encode 3 "haskell is fun"
    print $ encode (-3) $ encode 3 "haskell is fun"
    print $ crack "kdvnhoo lv ixq"
    print $ crack $ encode 3 "haskell"
    print $ crack "vscd mywzboroxcsyxc kbo ecopev"
    print $ crack $ encode 3 "boxing wizards jump quickly"
    print $ crack $ encode 7 "my name is dentaku. nice to meet you!"
