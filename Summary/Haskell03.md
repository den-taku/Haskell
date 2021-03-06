# 第3章 型と型クラス

**型** : 互いに関連する値の集合
 - T -> F T型からF型へ変換する関数
 - v :: T vはT型の値という意味
   - 評価前の値にも使える
 - 全ての式に型がつく
   - **型推論** によって決定(型つけ規則)
   - したがってHaskellは **型安全**

**基本型**
 - **Bool**
   - FalseとTrue
 - **Char**
   - シングルクォート
 - **String**
   - ダブルクォート
 - **Int**
   - 固定長
 - **Integer**
   - 多倍長整数
     - 上限・下限なし
 - **Float**
   - 単精度浮動小数点数
 - **Double**
   - 倍精度浮動小数点数

**リスト型**
 ```haskell
 [False, True, False] :: [Bool]
 ```
 - 同じ型の要素の並び
 - 型に長さの情報は含まれない
 - 型・長さに制限はない
   - 無限長も可能

**タプル型**
```haskell
(False, True) :: (Bool, Bool)
("Yes", True, 'a') :: (String, Bool, Char)
```
 - 有限個の要素の組
   - 要素数0のタプルはユニット，要素数1のタプルは許されていない
 - 型に長さの情報は含まれる
 - 型に制限はない
 - ただし有限長しか許されない 
   - 型が評価前に決定できないといけないため

**関数型**
```haskell
not :: Bool -> Bool
enen :: Int -> Bool
```
 - ある型の引数を他の型の結果に変換する
 - 全域関数である必要はない
 - Curryingできる
   - もちろん部分適用もできる

**多相型**
```haskell
length :: [a] -> Int
```
 - 型変数を使って型抽象

**多重定義型**
```haskell
(+) :: Num a => a -> a -> a
```
 - 型クラス制約
   - 型クラス`C`，型変数`a`として`C a`
 - 一つ以上の型クラス制約をもつなら**多重定義型**と呼ばれる
 - インスタンス自体にも型クラス制約を与えることができる
```haskell
let n = 3 :: Num a => a
```

**型クラス**(あるいは単に**クラス**)
 - 共通の**メソッド**を提供する型の集合
   - メソッド : 多重定義された操作
 - 使用頻度が高いクラス
   - `Eq`
   - `Ord`
   - `Show`
   - `Read`
     - `read "purseする文字列" :: (型)`とする(多くの場合は推論できる)
   - `Num`
   - `Integral`
   - `Fractilnal`