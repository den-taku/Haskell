module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    -- let e = Add (Add (Val 2) (Val 3)) (Val 4)
    -- print $ eval e
    -- print $ comp e
    -- print $ exec (comp e) []
    print "Hey"
    print $ eval (Add (Val 1) (Val 2))
    print $ eval' (Add (Val 1) (Val 2)) []
    let e = Add (Add (Val 2) (Val 3)) (Val 4)
    print $ comp e
    print $ eval e

data Expr = Val Int | Add Expr Expr

eval :: Expr -> Int
-- eval (Val n)   = n
-- eval (Add x y) = eval x + eval y
eval e = head (eval' e [])

type Stack = [Int]

eval' :: Expr -> Stack -> Stack
-- eval' (Val n) s   = push n s
-- eval' (Add x y) s = add (eval' y (eval' x s))
-- eval' e s = eval'' e id s
eval' e = eval'' e haltC

push :: Int -> Stack -> Stack
push n s = n : s

add :: Stack -> Stack
add (m : n : s) = n + m : s

type Cont = Stack -> Stack

eval'' :: Expr -> Cont -> Cont
eval'' (Val n) c   = pushC n c
eval'' (Add x y) c = eval'' x (eval'' y (addC c))

haltC :: Cont
haltC = id

pushC :: Int -> Cont -> Cont
pushC n c = c . push n

addC :: Cont -> Cont
addC c = c . add

data Code = HALT | PUSH Int Code | ADD Code deriving Show

exec :: Code -> Stack -> Stack
exec HALT    s            = s
exec (PUSH n c) s         = exec c (n : s)
exec (ADD c)  (m : n : s) = exec c (n+m : s)

comp :: Expr -> Code
comp e = comp' e HALT

comp' :: Expr -> Code -> Code
comp' (Val n) c   = PUSH n c
comp' (Add x y) c = comp' x (comp' y (ADD c))

-- type Stack = [Int]
-- type Code = [Op]
-- data Op = PUSH Int | ADD deriving Show

-- exec :: Code -> Stack -> Stack
-- exec [] s                  = s
-- exec (PUSH n : c) s        = exec c (n : s)
-- exec (ADD : c) (m : n : s) = exec c (n + m : s)

-- comp :: Expr -> Code
-- comp (Val n)   = [PUSH n]
-- comp (Add x y) = comp x ++ comp y ++ [ADD]
