module Tspace where

{-
data MaybeNull a = JustVal a | Null deriving(Show)
instance (Eq a) => Eq (MaybeNull a) where
    JustVal x == JustVal y = x==y
    Null == Null = True
    _ == _  = False
-}

--Eq3 typeclass
class Eq3 a where
    (===) :: a -> a -> Bool3

--Bool3
data Bool3 = False3 | Unk3 | True3 deriving (Eq,Show)
instance Eq3 Bool3 where
    True3 === True3 = True3
    False3 === False3 = True3
    Unk3 === Unk3 = True3
    _ === _ = False3

--MaybeNull
data MaybeNull a = JustVal a | Null deriving(Eq,Show)
instance (Eq3 a) => Eq3 (MaybeNull a) where
    JustVal x === JustVal y = x===y
    JustVal x === Null = False3
    Null === JustVal y = False3
    _ === _ = Unk3 
