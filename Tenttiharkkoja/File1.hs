module File1 where

length1 :: (Num b) => [a] -> b
length1 [] = 0
length1 (x:xs) = 1 + length1 xs

length2 :: (Num b) => [a] -> b -> b
length2 [] i = i
length2 (x:xs) i = length2 xs i+1

capital :: String -> String  
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x] 

myCompare :: (Ord a) => a -> a -> Ordering  
a `myCompare` b  
    | a > b     = GT  
    | a == b    = EQ  
    | otherwise = LT 

max' :: (Ord a) => a -> a -> a
max' a b = case c of
            True -> a
            _ -> b
            where c = (==) GT $ myCompare a b


initials :: String -> String -> String  
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."  
    where (f:_) = firstname  
          (l:_) = lastname 

initials' :: String -> String -> String  
initials' (f:_) (l:_) = [f] ++ ". " ++ [l] ++ "."             

divideByTen :: (Floating a) => a -> a  
divideByTen = (/10)

divideByTen' :: (Floating a) => a -> a  
divideByTen' = (*) (1/10)

applyTwice :: (a -> a) -> a -> a  
applyTwice f x = f (f x) 


applyTwice' :: (a -> a) -> a -> a  
applyTwice' f x = (.) f f x

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (a:as) (b:bs) = f a b : zipWith' f as bs

flip' :: (a -> b -> c) -> b -> a -> c
flip' f x y = f y x

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (a:as)
    | f a = a : filter' f as
    | otherwise = filter' f as


quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (a:as) =
    let smaller = quicksort $ filter' (<a) as
        larger = quicksort $ filter' (>=a) as
    in smaller ++ [a] ++ larger

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' f (a:as)
    | f a = a : takeWhile' f as
    | otherwise = []




