module File4 where


main2 = do   
    line <- getLine  
    putStrLn $ reverseWords line  
    --main2             
  
reverseWords :: String -> String  
reverseWords = unwords . map reverse . words 

data CMaybe b a = CNothing | CJust b a deriving (Show)

instance Functor (CMaybe b) where
    fmap f CNothing = CNothing  
    fmap f (CJust b a) = CJust b (f a) 

main = do  
    a <- (++) <$> getLine <*> getLine  
    putStrLn $ "The two lines concatenated turn out to be: " ++ a 


newtype CharList = CharList { getCharList :: [Char] } deriving (Eq, Show)    


newtype Pair b a = Pair { getPair :: (a,b) }
instance Functor (Pair c) where  
    fmap f (Pair (x,y)) = Pair (f x, y)


--On newtype laziness
--data CoolBool = CoolBool { getCoolBool :: Bool }
newtype CoolBool = CoolBool { getCoolBool :: Bool } 

helloMe :: CoolBool -> String  
helloMe (CoolBool _) = "hello" 

