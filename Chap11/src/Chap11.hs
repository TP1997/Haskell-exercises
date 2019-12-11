module Chap11 where

import Data.Char
import Data.List

--------------------------------Functors redux----------------------------------------------
main :: IO ()
main = do line <- fmap (intersperse '-' . reverse . map toUpper) getLine  
          putStrLn line 

{- GRAVEYARD
main = do line <- fmap reverse getLine  
          putStrLn $ "You said " ++ line ++ " backwards!"  
          putStrLn $ "Yes, you really said " ++ line ++ " backwards!" 

-}

data CMaybe a = CNothing | CJust Int a deriving (Show)
instance Functor CMaybe where
    fmap f CNothing = CNothing
    fmap f (CJust counter x) = CJust (counter+1) (f x)
--^Actually, CMaybe is not a functor    

--------------------------------Applicative functors-----------------------------------------

