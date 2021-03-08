# 第12章 モナドなど

**関手(functor)**
 - 圏論だと圏Cから圏Dへ対応させるやつ(お気持ち理解)
 - ```haskell
    class Functor where
        fmap :: (a -> b) -> f a -> f b
   ```
 - `fmap`で要素の処理が汎用的にできるのが嬉しい
 - **関手則**
   - ```haskell
     fmap id      = id
     fmap (g . h) = fmap g . fmap h
     ```
   - 同型
   - 関手則を満たす`fmap`は高々一つ