module Funcs where

readMaybe :: (Read a) => String -> Maybe a
readMaybe st = case reads st of
               [(x,"")] -> Just x
               _ -> Nothing

--Not tail recursive sum function (Populates stack):
sum''' []=0
sum''' (x:xs) = x + sum''' xs

--Yes tail recursive version
--After the final recursive function call, the result is ready.        
sum' xs=sum'' xs 0
sum'' [] n=n
sum'' (x:xs) n=sum'' xs (n+1)

h=do
  x <- Just 3
  y <- Just "!"
  z <- Nothing
  Just (show x ++ y ++ z)