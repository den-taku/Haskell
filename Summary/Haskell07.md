# 第7章 高階関数

**高階関数** : 引数や返り値として関数を扱える関数

**ドメイン固有言語** (DSL : domain specific language)を作成するのに利用可能

`map` : 与えられた関数をリストの要素全てに適用

`filter` : **述語**を満たす要素を全て取り出す

`all` : 全てが述語を満たすか

`any` : どれかが述語を満たすか

`takeWhile` : 先頭から述語を満たすものまで取り出す

`dropWhile` : 先頭から述語を満たすものまで取り除く

`foldr`: cons演算子をfに，空リストをvに置き換える

```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f v []     = v   
foldr f v (x:xs) = f x (foldr f v xs)
```