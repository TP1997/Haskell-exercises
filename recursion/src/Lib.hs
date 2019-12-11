module Lib where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

max' :: [Int] -> Int
max' [] = error "Error!"
max' [x] = x
max' (x:xs) | x > restMax = x
            | otherwise = restMax
            where restMax = max' xs

replicate' :: Int -> Int -> [Int]
replicate' 0 x = []
replicate' n x = x:replicate' (n-1) x

take' :: Int -> [Int] -> [Int]
take' _ [] = []
take' n (l:ls)
    |n <= 0     = []
    | otherwise = l:restList
    where restList = take' (n-1) ls

take2' :: Int -> [Int] -> [Int]
take2' n _  
    | n <= 0   = []  
take2' _ []     = []  
take2' n (x:xs) = x : take' (n-1) xs

reverse' :: [Int] -> [Int]
reverse' [] = []
reverse' (x:xs) = (reverse' xs)++[x]

zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

elem' :: (Eq a) => a -> [a] -> Bool
elem' e [] = False
elem' e (x:xs)
    | x==e      = True
    | otherwise = elem' e xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerPart = quicksort [a | a<-xs, a<=x] 
        largerPart  = quicksort [a | a<-xs, a>x]
    in smallerPart++[x]++largerPart

task4 :: (Real a) => [a] -> [a]
task4 [x] =[]
task4 (x:y:rest)
    | x<y       = x:(task4 (y:rest))
    | otherwise = task4 (y:rest)

--Produce infinite list
repeat' :: a -> [a]  
repeat' x = x:repeat' x 