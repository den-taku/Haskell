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