module Lib
    ( someFunc
    ) where

import Data.Typeable
import Data.Monoid

someFunc :: IO ()
someFunc = do
    let unit = print "Lib!"
    print $ typeOf unit
    print $ mconcat [Sum 2, Sum 3, Sum 4]
    print $ getSum $ mconcat [Sum 2, Sum 3, Sum 4]
    print $ mconcat [Product 2, Product 3, Product 4]
    print $ getProduct $ mconcat [Product 2, Product 3, Product 4]
    print $ mconcat [All True, All True, All True]
    print $ getAll $ mconcat [All True, All True, All True]
    print $ mconcat [Any False, Any False, Any False]
    print $ getAny $ mconcat [Any False, Any False, Any False]
    print $ getAll $ All True <> All True <> All True
