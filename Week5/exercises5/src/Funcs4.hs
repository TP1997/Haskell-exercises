{-# LANGUAGE ScopedTypeVariables, DataKinds, KindSignatures #-}

module Funcs4 where

--Note:
--I think the instructions were a bit unclear, so there might be some issues in the code.
--Also the Null===Null comparison gives error which reason I couldn't found/understand.

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
data MaybeNull a = JustVal a | Null
instance (Eq3 a) => Eq3 (MaybeNull a) where
    JustVal x === JustVal y = x===y
    Null === Null = Unk3
    _ === _ = False3    

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

