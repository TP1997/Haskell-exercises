module Arviointi where

import Data.Char

--Task 1
--Part 1
isADigit :: Char -> Bool
isADigit c = c <= '9' && c >= '0'

digitsOrNot :: String -> Bool
digitsOrNot [] =  False
digitsOrNot [x]
    | isADigit x = True
    | otherwise = digitsOrNot []
digitsOrNot (x:xs)
    | not (isADigit x) = False
    | otherwise = digitsOrNot xs
--Part 2
task21 :: [Char] -> Bool
task21 [] = True
task21 (c:cs) =
  let digits = ['0'..'9']
  in if c `elem` digits
     then task21 cs
     else False

--Task 2
--task22.hs
-- Validates strings as Finnish IBAN code.
-- For details, see https://en.wikipedia.org/wiki/International_Bank_Account_Number#Validating_the_IBAN
--
-- Finnish IBAN code:
--  * Length = 18
--  * Begins with country code FI
--  * All other characters are digits except for the first two.
--  * Assumption: no whitespaces
--
-- Validation returns True if the string is valid.
-- Otherwise returns False.

validateFinnishIBAN :: [Char] -> Bool
validateFinnishIBAN []   = False            -- empty string
validateFinnishIBAN (x:x':xs)
 | length xs /= 16         = False          -- total length is 18
 | (x /= 'F' || x' /= 'I') = False          -- begins with "FI"
 | otherwise               = onlyDigits xs
 where onlyDigits :: [Char] -> Bool
       onlyDigits []       = False
       onlyDigits (x:xs)
         | Data.Char.isDigit x = (length xs == 0 || onlyDigits xs)
         | otherwise           = False 
--2-2.hs
iban :: [Char] -> Bool
iban [] = False
iban (x:xs)
   | length xs > 17 = False
   | length xs == 17 && x == 'F' = iban xs
   | length xs == 16 && x == 'I' = iban xs
   | length xs == 17 && x /= 'F' = False
   | length xs == 16 && x /= 'I' = False
   | length xs < 16 && length xs > 0 && x >= '0' && x <= '9' = iban xs
   | length xs < 16 && length xs > 0 && x < '0' || x > '9' = False
   | otherwise = True         

compareChars :: Char -> Char -> Bool
compareChars c1 c2 = c1 == c2
--Task 3  
--2.3.hs
{- 
   Gave a shot at this but unfortunately couldnt get this to compile.
   The error seems to be the calling of checkString recursively with
   incorrect parameters. Otherwise the logic should be fine, afaik.
   Up to you to determine whether or not this is worth the points.
-}
{-}
checkString :: Int -> (Char, Char) -> String -> Int -> Int -> Int -> Int
checkString l (c1,c2) s g i j = 
    do
        let comparable1 =  s !! i
        let comparable2 = s !! i + g

        if compareChars comparable1 c1 && comparable2 c2
            then    j + 1
            else    return ()
        let i = i + 1
        checkString (l-1)

compareChars :: Char -> Char -> Bool
compareChars c1 c2 = c1 == c2

checkString2 :: (Char, Char) -> String -> Int -> Int -> Int -> Int
checkString2 (c1,c2) s g i j = checkString ((length s) - (g + 1)) (c1, c2) s g i j
--main (c1,c2) s g i j = checkString ((length s) - (g + 1)) (c1, c2) s g i j
--
-}
--task2 3.hs
checkGap :: (Char, Char) -> Int -> [Char] -> Int
checkGap (c1, c2) gap str = if length str >= gap + 2 && str !! 0 == c1 && str !! (gap + 1) == c2 then 1 else 0

checkMatches :: (Char, Char) -> Int -> [Char] -> Int
checkMatches (c1, c2) gap [] = 0
checkMatches (c1, c2) gap str = checkGap (c1, c2) gap str + checkMatches (c1, c2) gap (tail str)

--Task 4
--Task_2_4.hs
f :: String -> String -> String
f [] [] = ""
f _ [] = ""
f [] _ = ""
f (c:s1) s2 = if elem c s2
  then c : f s1 (tail (dropWhile (/=c) s2))
  else f s1 s2
--task2_4.hs (alempi)  
subStringOfTwo :: [Char] -> [Char] -> [Char]
subStringOfTwo [] _ = ""
subStringOfTwo _ [] = ""
subStringOfTwo (x:xs) (y:ys)
        | x == y = [x] ++ subStringOfTwo' xs ys
        | otherwise = subStringOfTwo xs (y:ys)
subStringOfTwo' [] _ = ""
subStringOfTwo' _ [] = ""
subStringOfTwo' (x:xs) (y:ys)
        | x == y = [x] ++ subStringOfTwo' xs ys
        | otherwise = subStringOfTwo' xs ys