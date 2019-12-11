module A4_2 where

class Eq3 a where  
   (===) :: a -> a -> Bool3  
   (/==) :: a -> a -> Bool3  
   x === y = not3 (x /== y)  
   x /== y = not3 (x === y)  

-- MaybeNull:

data MaybeNull a = JustVal a | Null deriving (Show, Eq)

instance (Eq a) => Eq3 (MaybeNull a) where
   (===) Null _   = Unk3
   (===) _ Null   = Unk3
   (===) (JustVal x) (JustVal y)
      | x == y    = True3
      | otherwise = False3

-- Bool3:

data Bool3 = False3 | Unk3 | True3 deriving (Show, Eq) 

instance Eq3 Bool3 where
   (===) x y
      | x == Unk3 || y == Unk3  = Unk3
      | x == y                  = True3 
      | otherwise               = False3

(&&&) :: Bool3 -> Bool3 -> Bool3
(&&&) x y
   | x == True3 && y == True3   = True3
   | x == False3 || y == False3 = False3
   | otherwise                  = Unk3

(|||) :: Bool3 -> Bool3 -> Bool3
(|||) x y
   | x == True3 || y == True3   = True3
   | x == False3 && y == False3 = False3
   | otherwise                  = Unk3

not3 :: Bool3 -> Bool3
not3 x
   | x == True3  = False3
   | x == False3 = True3
   | otherwise   = Unk3

-- (Kleene's) implication just for fun
(--->) :: Bool3 -> Bool3 -> Bool3
x ---> y = (not3 x) ||| y


-- Truth tables. Not my code but adapted from: https://rosettacode.org/wiki/Category:Haskell
inputs1 = [True3, Unk3, False3]
inputs2 = [(a,b) | a <- inputs1, b <- inputs1]
 
unary f = map (\a -> [a, f a]) inputs1
binary f = map (\(a,b) -> [a, b, f a b]) inputs2
 
table name xs = map (map pad) . (header :) $ map (map show) xs
    where header = map (:[]) (take ((length $ head xs) - 1) ['A'..]) ++ [name]

pad s = s ++ replicate (7 - length s) ' '

showTruthTables = mapM_ (putStrLn . unlines . map unwords)
    [ table "NOT"     $ unary not3
    , table "AND"     $ binary (&&&)
    , table "OR"      $ binary (|||)
    , table "IMPLIES" $ binary (--->)
    , table "EQUALS"  $ binary (===)
    ]