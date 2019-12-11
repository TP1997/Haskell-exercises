module A3_1 where

{-
6.3 Make a program that reads repeatedly lines from terminal (that is a program you need to compile). If the line is follows the format of one of the three lines below:
Int ‘+’ Int
Int ‘-‘ Int
Int ‘*’ Int
then calculate the result of the arithmetic operation. Otherwise output an error message, like “I cannot calculate that” or something. Stop when the user types “quit”
You can use the prompt you like. putStr prints a string without the line change. A possible execution:
calc> 3 + 5
8
calc> a + 3
I cannot calculate that
calc> 4 - 3
1
calc> quit
bye
-}

import Data.Maybe (fromJust, isJust, listToMaybe)


maybeRead:: Read a => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads

main = do   
    putStr "Calc > "
    line <- getLine  
    if line == "quit"
       then print "k thnx bye"
       else do 
            case parse line of
                Just (x, op, y) -> print (op x y)
                Nothing -> print("I cannot calculate that or something") -- "or something" is intentionally left there
            main  

parse :: String -> Maybe (Int, (Int -> Int -> Int), Int)
parse s = case (words s) of
    [x, y, z] -> let xx = (maybeRead x)::(Maybe Int)
                     yy = case y of
                               "+" -> Just (+)
                               "-" -> Just (-)
                               "*" -> Just (*)
                               --"/" -> Just (/)
                               _ -> Nothing
                     zz = (maybeRead z)::(Maybe Int)
                 in if (isJust xx && isJust yy && isJust zz)
                    then Just (fromJust xx, fromJust yy, fromJust zz)
                    else Nothing
    _ -> Nothing