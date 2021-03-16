# 第12章 モナドなど

**Functor(関手)**
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

**Applicative(アプリカティブ(関手))**
 - 複数の引数を取れるようにFunctorを拡張したもの
 - 次の二つの関数さえあればカリー化して任意の数の引数に対応可能
   - ```haskell
     pure :: a -> f a
     (<*>) :: f (a -> b) -> f a -> f b
     ```
 - **アプリカティブスタイル**で使う
   - ```haskell
     pure (+) <*> (Just 1) <*> (Just 2)
     ```
 - ```haskell
   class Functor f => Applicative f where
       pure :: a -> f a
       (<*>) :: f (a -> b) -> f a -> f b 
   ```
 - 非決定性プログラミングの枠組みが提供される
 - Applicativeは逐次と繰り返しを実現する
   - `sequenceA :: Applicative f => [f a] -> f [a]` など
 - **アプリカティブ則**
   - ```haskell
     pure id <*> x   = x
     pure (g x)      = pure g <*> pure x
     x <*> pure y    = pure (\g -> g y) <*> x
     x <*> (y <*> z) = (pure (.) <*> x <*> y) <*> z 
     ```
 - `fmap`の中置演算子`<$>`
   - これによりApplicative stileを`g <$> x1 <*> x2 <*> ... <*> xn` のようにかける
 - 「純粋な関数」を「作用をもつ引数」に適用する

**Monad**
 - `>>=` : **bind演算子**
    - 「失敗するかもしれない型aの値」を「失敗するかもしれない型a->b」に適用 
    - ```haskell
      m1 >>= \x1 ->
      m2 >>= \x2 ->
      .
      .
      .
      mn >>= \xn ->
        f x1 x2 ... xn
      ```
    - これは次のようにかける
    ```haskell
       do x1 <- m1
          x2 <- m2
          .
          .
          .
          xn <- mn
          f x1 x2 ... xn
    ```
 - ```haskell
   class Applicative m => Monad m where
     return :: a -> m a
     (>>=) :: m a -> (a -> m b) -> m b

     return = pure
   ```

Applicativeは逐次と繰り返し，Monadは分岐