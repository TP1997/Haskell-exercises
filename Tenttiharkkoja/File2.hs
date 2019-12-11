module File2 where

addThree :: (Num a) => a -> a -> a -> a  
addThree = \x -> \y -> \z -> x + y + z  

addThree' :: (Num a) => a -> a -> a -> a  
addThree' x = \y -> \z -> x + y + z

addThree'' :: (Num a) => a -> a -> a -> a  
addThree'' x y z = x + y + z  

flip' :: (a -> b -> c) -> b -> a -> c
flip' = \f -> \b -> \a -> f a b

flip'' :: (a -> b -> c) -> b -> a -> c
flip'' = \f -> \b a -> f a b

sum' :: (Num a) => [a] -> a  
sum' xs = foldl (\acc x -> acc + x) 0 xs 

sum'' :: (Num a) => [a] -> a  
sum'' xs = foldr (\acc x -> acc + x) 0 xs 

elem' :: (Eq a) => a -> [a] -> Bool
elem' a = foldl (\acc x -> if x == a then True else acc) False

maximum' :: (Ord a) => [a] -> a
maximum' = foldl1 (\acc x -> if x > acc then x else acc)

maximum'' :: (Ord a) => [a] -> a
maximum'' = foldr1 (\x acc -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' = foldl (\acc x -> x:acc) []

reverse'' :: [a] -> [a]
reverse'' = foldr (\x acc -> acc++[x]) []

product' :: (Num a) => [a] -> a
product' = foldl1 (\acc x -> acc*x)

product'' :: (Num a) => [a] -> a
product'' = foldr1 (\x acc -> acc*x)

filter' :: (a -> Bool) -> [a] -> [a]
filter' f = foldr (\x acc -> if f x then x:acc else acc) []

head' :: [a] -> a
head' = foldr1 (\x _ -> x)

last' :: [a] -> a
last' = foldl1 (\_ x -> x)

oddSquareSum :: Integer  
oddSquareSum = sum (takeWhile (<10000) (filter odd (map (^2) [1..]))) 

oddSquareSum' :: Integer  
oddSquareSum' = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]