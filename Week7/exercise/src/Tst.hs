module Tst where

prt :: [String] -> [String]
prt ("Tell":"me":"about":sEventname:[]) = [sEventname]
prt _ = []
{-
split :: [String] -> [String]
split [] _ = []
split (x:xs)
    | head x /= '\'' = x:(split xs)
    | otherwise = 

parse :: [String] -> Int -> (String, Int)
parse [] cnt = ([],cnt)
parse (x:xs) cnt
    | last x == '\'' = (x, cnt)
    | otherwise = (x++" "++(parse xs cnt), cnt+1)
-}
--filter (\s -> '\'' `elem` s) (words "Event 'Event X' happens at 'Place s Y' on '2019-10-08'")

split :: (Char -> Bool) -> String -> [String]
split f s = case dropWhile f s of
                "" -> []
                s' -> w:split f s''
                        where (w, s'') = break f s'


Event 'Event A' happens at 'Place A1' on '2001-02-02'

Event 'Event A' happens at 'Place A1' on '2001-02-03'

Event 'Event A' happens at 'Place A2' on '2001-02-03'

Event 'Event G1' happens at 'Place G' on '2008-02-02'

Event 'Event G21' happens at 'Place G' on '2008-02-02'

Event 'Event G22' happens at 'Place G' on '2008-02-02'

Event 'Event G0' happens at 'Place G' on '2009-02-02'

Event 'Event G4' happens at 'Place G' on '2010-02-02'

Event 'Event G5' happens at 'Place G' on '2011-02-02'

Event 'Event A' happens at 'Place A1' on '2001-00-00'