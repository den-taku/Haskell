module Comp
    (someFunc
    ) where

someFunc :: IO ()
someFunc = do
    print "Comp"
    print $ value $ Add (Add (Val 2) (Val 3)) (Val 4)
    print $ value2 $ Add (Add (Val 2) (Val 3)) (Val 4)

data Expr = Val Int | Add Expr Expr

value :: Expr -> Int
value (Val n)   = n
value (Add x y) = value x + value y

data Op = EVAL Expr | ADD Int
type Cont = [Op]

eval :: Expr -> Cont -> Int
eval (Val n)   c = exec c n
eval (Add x y) c = eval x (EVAL y : c)

exec :: Cont -> Int -> Int
exec []           n = n
exec (EVAL y : c) n = eval y (ADD n : c)
exec (ADD n : c)  m = exec c (n+m)

value2 :: Expr -> Int
value2 e = eval e []