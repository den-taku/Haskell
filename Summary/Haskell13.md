# 第13章 モナドパーサー

[ソースコード](https://github.com/den-taku/Haskell/tree/main/Chapter13/monadParser)をみて欲しい

`Alternative`
 - ```haskell
   class Applicative f => Alternative f where
       empty :: f a
       (<|>) :: f a -> f a -> f a
       many :: f a -> f [a]
       some :: f a -> f [a]

       many x = some x <|> pure []
       some x = pure (:) <*> x <*> many x
   ```
 - **選択肢(alternative)**という概念の抽象化
 - 以下の則を満たす必要がある
    - ```haskell
      empty <|> x     = x
      x <|> empty     = x
      x <|> (y <|> z) = (x <|> y) <|> z 
      ```