# 第4章 関数定義

関数を定義する方法

 - 既存の関数を組み合わせる
 - 条件式を用いる
   - ```haskell 
      if n >= 0 then n else -n
     ```
   - `else`部は省略不可能 
 - ガード付きの等式
   - ```haskell
      abs n | n >= 0    = n
            | otherwize = -n
     ```
 - パターンマッチ
   - ```haskell
      (&&) :: Bool -> Bool -> Bool
      True  && b = b
      False && _ = False
     ```
   <!-- - ```haskell -->
     <!-- // -->
     <!-- ``` -->
 - **ラムダ式**
   - ```haskell
       (\x -> x + x)2
     ```

**演算子**
 - 引数の間に置かれる関数
 - **セクション**
   - `#`を演算子として`(#)`，`(x #)`，`(# y)`
     - ```haskell
        (#) = \x -> \y -> x # y
        (x #) = \y -> x # y
        (# y) = \x -> x # y
       ```

Listは**cons演算子** `:`と空リスト`[]`を使って生成