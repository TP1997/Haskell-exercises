module File2 where

import qualified Control.Monad as M

type KnightPos = (Int,Int)

moveKnight :: KnightPos -> [KnightPos]  
moveKnight (c,r) = do  
    (c',r') <- [(c+2,r-1),(c+2,r+1),(c-2,r-1),(c-2,r+1)  
               ,(c+1,r-2),(c+1,r+2),(c-1,r-2),(c-1,r+2)  
               ]  
    M.guard (c' `elem` [1..8] && r' `elem` [1..8])  
    return (c',r') 

in3_1 :: KnightPos -> [KnightPos]  
in3_1 start = do   
    first <- moveKnight start  
    second <- moveKnight first  
    moveKnight second

in3_2 :: KnightPos -> [KnightPos]
in3_2 start = return start >>= moveKnight >>= moveKnight >>= moveKnight

canReachIn3 :: KnightPos -> KnightPos -> Bool  
canReachIn3 start end = end `elem` in3_2 start

(<=<) :: (Monad m) => (b -> m c) -> (a -> m b) -> (a -> m c)  
f <=< g = (\x -> g x >>= f) 