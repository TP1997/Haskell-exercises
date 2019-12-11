module File3 where
-- Remember: value constructors are just functions which
-- take values as parameters and return a value of some type
-- eg, Circle :: Float -> Float -> Float -> Shape

                --value constructor     value constructor
data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)

data Point = Point Float Float deriving (Show) 

                       -- Just functions, eg firstName :: Person -> String
data Person = Person { firstName :: String  
                     , lastName :: String  
                     , age :: Int  
                     , height :: Float  
                     , phoneNumber :: String  
                     , flavor :: String  
                     } deriving (Show) 

-- type constructors
data Vector a = Vector a a a deriving (Show)
data Vec a = Vec a deriving (Show)
data Vec' a b = Vec' a b a deriving (Show)



type Name = String 

data Either' a b = Left' a | Right' b deriving (Eq, Ord, Read, Show) 


--Recursive data structures
data List2 a = Empty2 | Cons2 a (List2 a) deriving (Show, Read, Eq, Ord)

infixr 5 :-:  
data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)  

infixr 5  .++  
(.++) :: List a -> List a -> List a   
Empty .++ ys = ys  
(x :-: xs) .++ ys = x :-: (xs .++ ys)