module Lib where

task1 :: Int -> [(Int,Int)]
task1 x = [(a,b) | a<-[-x..x], b<-[-x..x], abs a+ abs b<=x]

task2 :: [[Char]] -> Char -> [[Char]]
task2 sl c = [s | s<-sl, head s==c || last s==c]

task3 :: (Char,Int) -> (Char,Int) -> Int
task3 c1 c2
    | gotAce               = 14
    | gotSame && gotConsec = 8
    | gotPair              = 6
    | gotConsec            = 4
    | gotSame              = 2
    | otherwise            = 0
    where gotAce    = (snd c1==14 || snd c2==14)
          gotPair   = (snd c1==snd c2)
          gotSame   = (fst c1==fst c2)
          gotConsec = (abs (snd c1-snd c2)==1)

task4 :: (Real a) => [a] -> [a]
task4 [x] =[]
task4 (x:y:rest)
    | x<y       = x:(task4 (y:rest))
    | otherwise = task4 (y:rest)