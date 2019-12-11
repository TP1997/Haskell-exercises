module A3_2 where

import Control.Monad (when)
import Data.Maybe (fromJust, isJust)
import Text.Read (readMaybe)

main :: IO ()
main = do
  takeCalculations
  putStrLn "bye"

takeCalculations :: IO ()
takeCalculations = do
  putStr "calc> "
  input <- getLine
  let operator
        | (length . concat) (split (== '+') input) /= length input = '+'
        | (length . concat) (split (== '-') input) /= length input = '-'
        | (length . concat) (split (== '*') input) /= length input = '*'
        | otherwise = ' '
      left = readMaybe $ head $ split (== operator) input :: Maybe Integer
      right = readMaybe $ last $ split (== operator) input :: Maybe Integer
  when (input /= "" && input /= "quit")
    (putStrLn $ if isJust left && isJust right
                then case operator of
                       '+' -> show . fromJust $ (+) <$> left <*> right
                       '-' -> show . fromJust $ (-) <$> left <*> right
                       '*' -> show . fromJust $ (*) <$> left <*> right
                       _ -> "I cannot calculate that"
                else "I cannot calculate that")
  when (input /= "quit") takeCalculations

-- an implementation of split where the split character isn't included
-- in the list of strings
split :: (a -> Bool) -> [a] -> [[a]]
split f x =
  let first = takeWhile (not . f) x
      second = drop 1 $ dropWhile (not . f) x
  in [first, second]