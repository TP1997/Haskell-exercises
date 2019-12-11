module C8r where
--Typeclasses 102 & rest of chapter 8

--Datatype definition: (TrafficLight==type constructor)
data TrafficLight = Red | Yellow | Green
--Instance definitions:
instance Eq TrafficLight where  
    Red == Red = True  
    Green == Green = True  
    Yellow == Yellow = True  
    _ == _ = False
instance Show TrafficLight where  
    show Red = "Red light"  
    show Yellow = "Yellow light"  
    show Green = "Green light"


{- ############## A yes-no typeclass ############################ -}

--Typeclass declaration:
class YesNo a where  
    yesno :: a -> Bool  
--Instance definitions:
--For Int-values
instance YesNo Int where  
    yesno 0 = False  
    yesno _ = True 
--For lists
instance YesNo [a] where  
    yesno [] = False  
    yesno _ = True
--For Booleans
instance YesNo Bool where  
    yesno = id
--For Maybe sometype
instance YesNo (Maybe a) where  
    yesno (Just _) = True  
    yesno Nothing = False
--For TrafficLight
instance YesNo TrafficLight where  
    yesno Red = False  
    yesno _ = True     

--Mimicing if statement with YesNo values:
yesnoIf :: (YesNo y) => y -> a -> a -> a  
yesnoIf yesnoVal yesResult noResult = if yesno yesnoVal then yesResult else noResult 

{- ################ Kinds and some type-foo ######################## -}