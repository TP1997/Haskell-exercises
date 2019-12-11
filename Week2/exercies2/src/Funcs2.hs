module Funcs where

map' :: (a -> b) -> [a] -> [b]  
map' _ [] = []  
map' f (x:xs) = f x : map' f xs

filter2' :: (Ord a) => (a -> Bool) -> [a] -> [a]
filter2' _ [] = []
filter2' f (x:xs)
    | f x       = x:filter2' f xs
    | otherwise = filter2' f xs

chain' :: (Integral a) => a -> [a]
chain' 1 = [1]
chain' n
    | odd n     = n:chain' (n*3+1)
    | otherwise = n:chain' (n `div` 2)

numLongChains :: Int
numLongChains = length (filter' isLong (map chain' [1..100]))
    where isLong xs = length xs > 15

--Only folds and horses
sum' :: (Num a) => [a] -> a
sum' = foldl (+) 0

map2' :: (a -> b) -> [a] -> [b]  
map2' f xs = foldr (\x acc -> f x : acc) [] xs 

map3' :: (a -> b) -> [a] -> [b]  
map3' f xs = foldl (\acc x -> f x : acc) [] xs 

elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldl (\acc x -> if x==y then True else acc) False ys

--Standard library functions by using folds
maximum' :: (Ord a) => [a] -> a
maximum' = foldl1 (\acc x -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' xs = foldl (\acc x -> x:acc)[] xs

reverse2' :: [a] -> [a]
reverse2' = foldl (flip (:))[]

product' :: (Num a) => [a] -> a
product' = foldl (*) 1

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x acc -> if p x then x : acc else acc) []

head' :: [a] -> a
head' = foldl1 (\_ x -> x)

last' :: [a] -> a
last' = foldr1 (\x _ -> x)

sqrtSums :: Int
sqrtSums = length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1

(sum . replicate 5 . max 6.7) 8.9




