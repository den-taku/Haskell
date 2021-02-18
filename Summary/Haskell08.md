# 第8章 型と型クラスの定義

型を宣言する方法

 - `type`でエイリアスをつける
   - ```haskell
     type String = [Char] 
     ```
 - `data`で新しい型を定義
   - ```haskell
     data Bool = False | True
     ```
   - 型の値は**構成子**と呼ぶ
   - 構成子に引数を持たせることもできる
     - ```haskell
       data Shape = Circle Float | Rect Float Float
       ```
     - 構成子は関数だと言える
 - `newtype`
   - 構成子，引数共に一つの時に使用可能
   - 別名ではなく別の型として処理系が処理
   - 構成子が除去されるので`data`よりも効率的

- `data`と`newtype`を用いた宣言では再帰可能

型クラス

 - `class`を用い新しい型クラスを宣言できる
   - ```haskell
     class Eq a where
        (==), (/=) :: a -> a -> Bool
        x /= y = not $ x == y
     ```
 - `instance`でそれぞれの型に実装
   - ```haskell
     instance Eq Bool where
        False == False = True
        True  == True  = True
        _     == _     = False
     ```