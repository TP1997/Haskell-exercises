module Funcs where

multThree :: (Num a) => a -> a -> a -> a  
multThree x y z = x * y * z 

compareWithHundred :: (Num a, Ord a) => a -> Ordering  
compareWithHundred = compare 100 

plusTwo :: (Num a) => a -> a -> a
plusTwo x y  = y+x+2

divideByTen :: (Floating a) => a -> a  
divideByTen = (/10) 

isUpperAlphanum :: Char -> Bool  
isUpperAlphanum = (`elem` ['A'..'Z']) 

subtFour :: (Num a) => a -> a
subtFour = subtract 4

--Some higher-orderism is in order
applyTwice :: (a -> a) -> a -> a  
applyTwice f x = f (f x) 

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]  
zipWith' _ [] _ = []  
zipWith' _ _ [] = []  
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f x y = f y x

--Maps and filters
--		 f-def  sec-param   out
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
    | f x       = x:filter' f xs
    | otherwise = filter' f xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
    let smallerPart = quicksort (filter' (<x) xs)
        largerPart  = quicksort (filter' (>=x) xs)
    in smallerPart ++ [x] ++ largerPart

largestDivisible :: (Integral a) => a  
largestDivisible = head (filter' p [100000,99999..])  
    where p x = x `mod` 3829 == 0 