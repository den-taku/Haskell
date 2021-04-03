module Lib
    ( someFunc
    ) where

import Data.Typeable

someFunc :: IO ()
someFunc = do
    let unit = print "Lib!"
    print $ typeOf unit
