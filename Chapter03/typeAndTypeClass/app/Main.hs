module Main where

import Lib

main :: IO ()
main = do
    -- print $ False :: Bool
    -- print $ not False :: Bool
    -- print $ not (not False) :: Bool
    print $ add (2, 3)
    print $ zeroto 7
    print $ mult 45 78 34
    let n = 3 :: Num a => a 
    print $ n + 9
    print $ n + 8.0
    print $ False == False
    print $ ('a', False) == ('a', False)
    print $ False < True
    print $ ('a', 2) < ('b', 1)
    print $ min 'a' 'b'
    print $ show [1, 2, 3]
    print $ (read "('a', False)" :: (Char, Bool))
    print $ "signum (-3) : " ++ (show $ signum (-3))
    print $ 7.0 / 2.0
    print $ recip 2.0
    
