module Funcs4 where

import qualified Data.Map as Map

readMaybe :: (Read a) => String -> Maybe a  
readMaybe st = case reads st of 
                [(x,"")] -> Just x  
                _ -> Nothing 
------------------------------------Data definitions--------------------------------------------------
--Phone stuff:
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Eq, Show, Read)

data CountryCode = CountryCode Integer deriving(Eq, Read)
data PhoneNo = PhoneNo Integer deriving(Eq, Read)
data Phone = Phone{ phoneType   :: PhoneType
                   ,countryCode :: CountryCode
                   ,phoneNo     :: PhoneNo} deriving (Eq, Read)

ccList = ["358", "359", "41", "84"]

type Phonebook = Map.Map String [Phone]
------------------------------------Instances---------------------------------------------------------
instance Show CountryCode where
    show (CountryCode cc) = "+" ++ show cc

instance Show PhoneNo where
    show (PhoneNo pn) = show pn

instance Show Phone where
    show (Phone pt cc pn) = show cc++" "++show pn++" ("++show pt++")"
------------------------------------Phone related functions-------------------------------------------
readPhone :: String -> String -> String -> Maybe Phone
readPhone pts ccs pns = let mpt   = readMaybe pts :: Maybe PhoneType
                            ccs' = removePrefix ccs
                                where removePrefix ('+':xs) = xs
                                      removePrefix ('0':'0':xs) = xs
                                      removePrefix xs = xs

                            mcc = toCountryCode' (readMaybe ccs' :: Maybe Integer)
                            mpn = toPhoneNo $ (readMaybe pns :: Maybe Integer)
                            in case (mpt,mpn,mcc) of 
                                (Just pt,Just pn,Just cc)  -> Just (Phone pt cc pn)
                                _ -> Nothing

toPhoneNo :: Maybe Integer -> Maybe PhoneNo
toPhoneNo (Just pni)
    | pni < 0   = Nothing
    | otherwise = Just (PhoneNo pni)
toPhoneNo _ = Nothing

toCountryCode' :: Maybe Integer -> Maybe CountryCode
toCountryCode' (Just cci)
    | cci < 0   = Nothing
    | not $ (show cci) `elem` ccList = Nothing
    | otherwise = Just (CountryCode cci)
toCountryCode' _ = Nothing                                   
------------------------------------Task related functions--------------------------------------------                  
findEntries :: String -> Phonebook -> [Phone]
findEntries nm pb = case Map.lookup nm pb of
                        Nothing -> []
                        (Just x) -> x

addEntry :: [String] -> Phonebook -> IO Phonebook
addEntry (name:pts:ccs:pns:_) pb =
    let phone = readPhone pts ccs pns
    in case phone of 
        Nothing -> returnWithMsg pb "Invalid phone parameters, changes not made."
        Just p -> case findEntries name pb of 
                    [] -> returnWithMsg (Map.insert name [p] pb) "done"
                    phones -> case (phoneNo p) `elem` (map phoneNo phones) of
                                True -> returnWithMsg pb "Phone number already exist, changes not made"
                                False -> returnWithMsg (Map.insert name (p:phones) pb) "done"                                

returnWithMsg :: a -> String -> IO a
returnWithMsg a s = do putStrLn s
                       return (a)
------------------------------------Main application--------------------------------------------------- 
--Application starts with empty phonebook.
main :: IO ()
main = main' Map.empty

--Phonebook allows to
--add several phones (with different phonenumbers) to single entry (name).
main' :: Phonebook -> IO ()
main' pb = do
            putStr "phonebook>"
            command <- getLine
            if command == "quit" then do
                putStrLn "Bye."
            else do
                let args = words command
                if args!!0 == "add" && length args == 5 then do 
                    newpb <- addEntry (drop 1 args) pb 
                    main' newpb
                else if args!!0 == "find" && length args == 2 then do
                    let phonelist = findEntries (args!!1) pb
                        in print phonelist
                    main' pb
                else do
                    putStrLn "Invalid input."
                    main' pb                                       

--example commands:
-- add Test1 Other 358 1111
-- add Test1 Other 358 2222
-- add Test1 Other 358 3333
-- add Test2 Other 358 4444
-- find Test1
-- find Test2
