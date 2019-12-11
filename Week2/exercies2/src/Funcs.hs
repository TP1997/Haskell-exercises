module Funcs where

import Data.Char (digitToInt)
import Data.List (elemIndices)
--Task 1
--True == contains only digits
task1 :: [Char] -> Bool
task1 [] = False
task1 (x:xs)
    | not $ elem x ['0'..'9'] = False
    | xs == []                = True
    | otherwise               = task1 xs

--Task 2
listToIntegral :: (Integral i) => [i] -> i
listToIntegral [] = 0
listToIntegral (x:xs) = 10^(length xs)*x + listToIntegral xs

task2 :: [Char] -> Bool
task2 iban
        | ( length iban /= 18 ) || ( take 2 iban /= "FI" ) || ( foldl (\acc x -> if elem x ['0'..'9'] then acc else True)False (drop 2 iban) ) = False
        | otherwise = (intForm `mod` 97) == 1
                    where intForm = listToIntegral $ map toInteger $ map digitToInt $ drop 4 iban ++ "1518" ++ drop 2 (take 4 iban)

--let iban="FI7550510620027653"
--let iban="FI2112345600000785"

--Task 3
task3 :: (Char, Char) -> Int -> [Char] ->Int
task3 (c1,c2) g (s:ss)
    | length ss < g+1        = 0
    | c1 == s && c2 == ss!!g = 1 + task3 (c1,c2) g ss
    | otherwise              = task3 (c1,c2) g ss

--Task 4
task4 :: [Char] -> [Char] -> [Char]
task4 [] _  = []
task4 _ []  = []
task4 s1 s2
            | (elemIndices (head s1) s2) /= [] = let idx = head $ elemIndices (head s1) s2 in (head s1):task4 (drop 1 s1) (drop (idx+1) s2)
            | (elemIndices (head s2) s1) /= [] = let idx = head $ elemIndices (head s2) s1 in (head s2):task4 (drop (idx+1) s1) (drop 1 s2)
            | otherwise                        = task4 (drop 1 s1) (drop 1 s2)
