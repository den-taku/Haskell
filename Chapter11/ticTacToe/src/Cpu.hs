module Cpu
    ( play, empty, Player(..)
    ) where

import Lib

data Tree a = Node a [Tree a]
    deriving Show

gametree :: Grid -> Player -> Tree Grid
gametree g p = Node g [gametree g' (next p) | g' <- moves g p]

moves :: Grid -> Player -> [Grid]
moves g p
    | won g     = []
    | full g    = []
    | otherwise = concat [move g i p | i <- [0..((size^2)-1)]]

prune :: Int -> Tree a -> Tree a
prune 0 (Node x _)  = Node x []
prune n (Node x ts) = Node x [prune (n-1) t | t <- ts]

depth :: Int
depth = 9

minimax :: Tree Grid -> Tree (Grid,Player)
minimax (Node g [])
    | wins O g  = Node (g,O) []
    | wins X g  = Node (g,X) []
    | otherwise = Node (g,B) []
minimax (Node g ts)
    | turn g == O = Node (g, minimum ps) ts'
    | turn g == X = Node (g, maximum ps) ts'
                    where
                        ts' = map minimax ts
                        ps  = [p | Node (_,p) _ <- ts']

bestmove :: Grid -> Player -> Grid
bestmove g p = head [g' | Node (g',p') _ <- ts, p' == best]
               where
                   tree = prune depth $ gametree g p
                   Node (_,best) ts = minimax tree

play :: Grid -> Player -> IO ()
play g p = do
    cls
    goto (1,1)
    putGrid g
    play' g p

play' :: Grid -> Player -> IO ()
play' g p
    | wins O g = putStrLn "Player O wins!\n"
    | wins X g = putStrLn "Player X wins!\n"
    | full g   = putStrLn "It's a draw!\n"
    | p == O   = do
        i <- getNat $ prompt p
        case move g i p of
            [] -> do
                putStrLn "ERROR: Invalid move"
                play' g p
            [g'] -> play g' $ next p
    | p == X = do
        putStr "Player X is thinking... "
        (play $! (bestmove g p)) $ next p