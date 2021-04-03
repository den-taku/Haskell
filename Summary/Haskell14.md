# 第14章 FoldableとTraversable

**モノイド**
 - **二項演算**と**単位元**をもつ集合
 - ```haskell
   class Monoid a where
       mempty :: a
       mappend :: a -> a -> a

       mconcat :: [a] -> a
       mconcat = foldr mappend mempty
   ```
 - 単位元と結合に関する則を満たす
    - ```haskell
      mempty `mappend` x          = x
      x `mappend` mempty          = x
      x `mappend` (y `mappend` z) = (x `mappend` y) `mappend` z
      ```