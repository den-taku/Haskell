module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    let e = Add (Add (Val 2) (Val 3)) (Val 4)
    print $ eval e
    print $ comp e
    print $ exec (comp e) []

data Expr = Val Int | Add Expr Expr

eval :: Expr -> Int
eval (Val n)   = n
eval (Add x y) = eval x + eval y

type Stack = [Int]

type Code = [Op]

data Op = PUSH Int | ADD
    deriving Show

exec :: Code -> Stack -> Stack
exec [] s                  = s
exec (PUSH n : c) s        = exec c (n : s)
exec (ADD : c) (m : n : s) = exec c (n + m : s)

comp :: Expr -> Code
comp (Val n)   = [PUSH n]
comp (Add x y) = comp x ++ comp y ++ [ADD]
