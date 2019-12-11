module File1 where

applyMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b  
applyMaybe Nothing f  = Nothing  
applyMaybe (Just x) f = f x     

type Birds = Int  
type Pole = (Birds,Birds)

landLeft :: Birds -> Pole -> Maybe Pole  
landLeft n (left,right)  
    | abs ((left + n) - right) < 4 = Just (left + n, right)  
    | otherwise                    = Nothing  
  
landRight :: Birds -> Pole -> Maybe Pole  
landRight n (left,right)  
    | abs (left - (right + n)) < 4 = Just (left, right + n)  
    | otherwise                    = Nothing

foo1 :: Maybe String  
foo1 = Just 3   >>= (\x -> 
       Just "!" >>= (\y -> 
       Just (show x ++ y))) 

foo2 :: Maybe String  
foo2 = do  
    x <- Just 3  
    y <- Just "!"  
    Just (show x ++ y)

marySue :: Maybe Bool  
marySue = do   
    x <- Just 9  
    Just (x > 8)    

routine1 :: Maybe Pole
routine1 = return (0,0) >>= landLeft 2 >>= landRight 2 >>= landLeft 1

routine2 :: Maybe Pole  
routine2 = do  
    start <- return (0,0)  
    first <- landLeft 2 start  
    --Nothing  
    second <- landRight 2 first  
    landLeft 1 second      

justH :: Maybe Char  
justH = do  
    (x:xs) <- Just "hello"  
    return x     

wopwop :: Maybe Char  
wopwop = do  
    (x:xs) <- Just ""  
    return x     

listOfTuples1 :: [(Int,Char)]
listOfTuples1 =  [1,2] >>= \n -> ['a','b'] >>= \ch -> return (n,ch)

listOfTuples2 :: [(Int,Char)]  
listOfTuples2 = do  
    n <- [1,2]  
    ch <- ['a','b']  
    return (n,ch)    

guard :: (MonadPlus m) => Bool -> m ()  
guard True = return ()  
guard False = mzero     
   