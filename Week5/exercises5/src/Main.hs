module Main where

data MyMaybe a = MyNothing | MyJust a

instance (Eq a) => Eq (MyMaybe a) where
  MyNothing == MyNothing = True
  MyJust x == MyJust y = x == y
  _ == _ = False

main :: IO ()
main = do
  let b0 = MyJust 42 == MyJust 42 -- OK
  print b0                        -- True
  let b1 = MyNothing == (MyNothing :: MyMaybe Int) -- Build error!
  print b1