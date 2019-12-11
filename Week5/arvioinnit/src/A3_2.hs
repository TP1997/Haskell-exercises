module A3_2 where

import qualified Data.Map as Map

-- DATA TYPES (COPY FROM TASK 4.4)
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Show, Eq, Read)

data CountryCode = CountryCode Integer deriving (Eq)
instance Show CountryCode where
  show (CountryCode x) = "+" ++ show x

createCountryCode :: Integer -> CountryCode
createCountryCode x
  | x < 0 = error "Negative not allowed!"
  | otherwise = CountryCode x

data PhoneNo = PhoneNo Integer deriving (Eq)
instance Show PhoneNo where
  show (PhoneNo x) = show x

createPhoneNo :: Integer -> PhoneNo
createPhoneNo x
  | x < 0 = error "Negative not allowed!"
  | otherwise = PhoneNo x

data Phone = Phone {
  phoneType :: PhoneType,
  countryCode :: CountryCode,
  phoneNo :: PhoneNo
} deriving (Eq)

instance Show Phone where
    show (Phone { phoneType = pt, countryCode = cc, phoneNo = pn }) =
        show cc ++ " " ++ show pn ++ " (" ++ show pt ++ ")"
  
-- list of allowed country codes
countryCodes = ["1", "33", "43", "49", "358"]

-- removes possible '+' char from beginning of country code String
trimString :: String -> String
trimString a
    | head a == '+' = tail a
    | otherwise = a

-- check if Country Code is in allowed list
ccIsAllowed :: [String] -> String -> String
ccIsAllowed allowed x
    | x `elem` allowed = x
    | otherwise = error "Not allowed country code"


-- read Phone info as String and create of type Phone instance
readPhone :: String -> String -> String -> Phone
readPhone pt cc pn = Phone {
    phoneType = read pt :: PhoneType, 
    countryCode = createCountryCode (read $ ccIsAllowed countryCodes $ trimString cc),
    phoneNo = createPhoneNo (read pn :: Integer)
}



-- PHONEBOOK RELATED DATA TYPES AND FUNCTIONS

-- seed some data to list of phonebook entries
phoneBookData = [("HerraA", (readPhone "WorkMobile" "+358" "1234567")),
            ("HerraB", (readPhone "Other" "+358" "9876543")),
            ("HerraB", (readPhone "PrivateMobile" "+49" "6667771")),
            ("HerraC", (readPhone "WorkLandline" "+43" "6667771")),
            ("HerraC", (readPhone "WorkMobile" "+43" "6667772")),
            ("HerraC", (readPhone "PrivateMobile" "+43" "6667773"))]

-- put data to Map data structure
-- uses fromListWith to compile list of Phone numbers for each key
phoneBook = Map.fromListWith (++) $ map (\(k, v) -> (k, [v])) phoneBookData

-- find by name functionality, returns list of numbers associated with name
--findByName :: [Map.Map] [Char] Phone -> 
findByName :: String -> Map.Map [Char] [Phone] -> Maybe [Phone]
findByName n pb = Map.lookup n pb

-- helper function to convert maybe list to standard list
maybeToList :: Maybe [a] -> [a]
maybeToList Nothing = []
maybeToList (Just xs) = xs

-- add new entry to map
-- check if name / Phone -combination already exists (raises error in case of)
-- returns new map, doesn't mutate original map
insertNewEntry :: String -> String -> String -> String -> Map.Map String [Phone] -> Map.Map String [Phone]
insertNewEntry n pt cc pn pb
    | newPhoneEntry `elem` (maybeToList (Map.lookup n pb)) = error "Number already exists for this name"
    | otherwise = Map.insertWith (++) n (newPhoneEntry : []) pb
    where newPhoneEntry = readPhone pt cc pn

--let entries1 = insertNewEntry  "entry7" "WorkLandline"  "358"  "77777" phoneBook
--findEntry "entry7" entries1          