第2章 はじめの一歩

多くの組み込み関数がpreludeの中で定義されている．以下例
 - head
 - tail
 - !!
 - take
 - drop
 - length
 - sum
 - product
 - ++
 - reverse
    - 使用頻度の高い定義は付録Bに

関数適用は空白，乗算には*を用いる
 - 関数適用はもっとも結合順位が高い

(stack) ghci (ファイル名)
 - ファイルの定義を読み込みつつREPL起動

コマンド(先頭一文字に短縮可能)
 - :load name        プログラムnameを読み込む
 - :reload           現在のプログラムを読み込む
 - :set editor name  エディターをnameに設定する
 - :edit name        プログラムnameを編集する 
 - :type expr        exprの型を表示する 
 - :?                全てのコマンドを表示
 - :quit             GHCiを終了する

命名規則
 - 関数と引数の先頭は小文字
 - 以降は大文字，小文字，数字，アンダースコア，シングルクォートが使用可能

予約語
 case class data default deriving do else foreign if import in
 infix infixl infixr instance let module newtype of then type where

レイアウト規則

コメントは--(行末まで)と{- -}(囲み)