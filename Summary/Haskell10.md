# 第10章 対話プログラム

副作用の扱い方

```haskell
type IO a = World -> (a,World)
```

「ある状態の世界」を受け取り「別の状態の世界」を返す純粋な関数とみなす

 - `getChar`
   - `getChar :: IO Char`
 - `putChar`
   - `putChar :: Char -> IO ()`
 - return`
   - `return :: Monad m => a -> m a`