module Tspace where

main :: a -> IO ()
main a = do
            putStr ">>"
            command <- getLine
            if command == "quit" then do
                putStrLn "Bye."
            else do 
                main a