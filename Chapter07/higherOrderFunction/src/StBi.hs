module StBi
    (
        printTest 
    ) where

import Data.Char

type Bit = Int

printTest = do 
    print "Hello, world!"
    print $ bin2int [1, 0, 1, 1]
    print $ int2bin 13
    print $ make8 [1, 0, 1, 1]
    print $ encode "abc"
    print $ decode [1,0,0,0,0,1,1,0,0,1,0,0,0,1,1,0,1,1,0,0,0,1,1,0]
    print $ transmit "higher-order functinos are easy"

-- bin2int :: [Bit] -> Int
-- bin2int bits = sum [w*b | (w, b) <- zip wights bits]
--                where wights = iterate (*2) 1
bin2int :: [Bit] -> Int
bin2int = foldr (\x y -> x + 2 * y) 0

int2bin :: Int -> [Bit]
int2bin 0 = []
int2bin n = n `mod` 2 : int2bin (n `div` 2)

make8 :: [Bit] -> [Bit]
make8 bits = take 8 (bits ++ repeat 0)

encode :: String -> [Bit]
encode = concat . map (make8 . int2bin . ord)

chop8 :: [Bit] -> [[Bit]]
chop8 []   = []
chop8 bits = take 8 bits : chop8 (drop 8 bits)

decode :: [Bit] -> String
decode = map (chr . bin2int) . chop8

transmit :: String -> String
transmit = decode . channel . encode

channel :: [Bit] -> [Bit]
channel = id