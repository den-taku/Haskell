module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = strlen

act :: IO (Char,Char)
act = do 
    x <- getChar
    getChar
    y <- getChar
    return (x,y)

getLine :: IO String
getLine = do 
    x <- getChar
    if x == '\n' then
        return []
    else 
        do xs <- Lib.getLine
           return (x:xs)
          
putStr :: String -> IO ()
putStr []     = return ()
putStr (x:xs) = do
    putChar x
    Lib.putStr xs

putStrLn :: String -> IO ()
putStrLn xs = do
    Lib.putStr xs
    putChar '\n'

strlen :: IO ()
strlen = do 
    Lib.putStr "Enter a string: "
    xs <- Lib.getLine
    Lib.putStr "The string has "
    Lib.putStr (show (length xs))
    Lib.putStrLn " characters"
