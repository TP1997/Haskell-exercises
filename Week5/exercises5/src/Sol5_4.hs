module Sol5_4 where

data MaybeNull a = JustVal a | Null

-- Bool3:

data Bool3 = False3 | Unk3 | True3 deriving (Eq,Show) 

(&&&) :: Bool3 -> Bool3 -> Bool3
(&&&) x y
 | x == True3 && y == True3 = True3
 | x == False3 || y == False3 = False3
 |otherwise = Unk3

(|||) :: Bool3 -> Bool3 -> Bool3
(|||) x y
 | x == True3 || y == True3 = True3
 | x == False3 && y == False3 = False3
 |otherwise = Unk3

not3 :: Bool3 -> Bool3
not3 x
 | x == True3 = False3
 | x == False3 = True3
 |otherwise = Unk3
 
class Eq3 a where
  (===) :: a -> a -> Bool3
  
instance Eq3 Bool3 where
  (===) True3  True3  = True3
  (===) False3 False3 = True3
  (===) True3  False3 = False3
  (===) False3 True3  = False3
  (===) _      _      = Unk3
  
instance (Eq3 a) => Eq3 (MaybeNull a) where
  (===) (JustVal x) (JustVal y) = x === y
  (===) (JustVal _) Null        = False3
  (===) Null        (JustVal _) = False3
  (===) Null        Null        = Unk3