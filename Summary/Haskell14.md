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
 - `Semigroup` (半群)などの型クラスもある

**Foldable**
 - データ構造の中の値をモノイドを使って畳み込む操作
 - ```haskell
   class Foldable t where
       fold    :: Monoid a => t a -> a
       foldMap :: Monoid b => (a -> b) -> t a -> b
       foldr   :: (a -> b -> b) -> b -> t a -> b
       foldl   :: (a -> b -> a) -> a -> t b -> a
   ```
    - 完全な定義には他にも有益なメソッドとデフォルト実装が提供されている
       - クラスのメソッドになっているのは実装の書き換えを可能にするため
    - 性能を向上させたかったらデフォルト実装を書き換えればよい
 - `foldMap`か`foldr`のどちらかを定義すれば汎用的な関数が適用できるようになる