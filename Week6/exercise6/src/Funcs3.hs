module Funcs3 where

readMaybe :: (Read a) => String -> Maybe a  
readMaybe st = case reads st of 
                [(x,"")] -> Just x  
                _ -> Nothing 

main :: IO ()
main = do
        putStr "calc>"
        command <- getLine
        if command=="quit" then do
            putStrLn "Bye."
        else do
            let args=words command
                op=args!!1
            if length args == 3 && length op==1 && (op!!0) `elem` "+-*" then do
                let n1 = readMaybe (args!!0) :: Maybe Int
                    op' = f (op!!0)
                        where f '+' = (+)
                              f '-' = (-)
                              f _   = (*)
                    n2 = readMaybe (args!!2) :: Maybe Int
                case op' <$> n1 <*> n2 of
                    (Just x) -> print x
                    _   -> putStrLn "Incorrect input."
            else do
                putStrLn "Incorrect input."
            main