module Arviointi4_1 where

-- Begin the code from task 2 and 3
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Show, Eq, Read)

data CountryCode = CountryCode Integer deriving (Eq)
instance Show CountryCode where
    show (CountryCode c) = show ('+':(show c))

data PhoneNo = PhoneNo Integer deriving (Eq)
instance Show PhoneNo where
    show (PhoneNo p) = show p

makeCountryCode :: Integer -> CountryCode
makeCountryCode cc
    | cc < 0 = error "Invalid country code, it should be a positive integer"
    | otherwise = CountryCode cc

makePhoneNo :: Integer -> PhoneNo
makePhoneNo p
    | p < 0 = error "Invalid phone number, it should be a positive integer"
    | otherwise = PhoneNo p

data Phone = Phone { phoneType :: PhoneType
                ,countryCode :: CountryCode
                ,phoneNo :: PhoneNo
            } deriving (Eq)
instance Show Phone where
    show Phone {phoneType = pt, countryCode = CountryCode c, phoneNo = pn} = show ("+" ++ (show c) ++ " " ++ (show pn) ++ " (" ++ (show pt) ++ ")")

makePhone :: PhoneType -> CountryCode -> PhoneNo -> Phone
makePhone pt cc pn = Phone {phoneType = pt, countryCode = cc, phoneNo = pn}

readPhone :: String -> String -> String -> Phone
readPhone rawPhoneType rawCode rawPhoneNum = if countryCodeOk then makePhone parsedPhoneType code phoneNum else error "Cannot find this country code"
    where
        parsedPhoneType = read rawPhoneType::PhoneType
        stripedRawCode = strip_initials rawCode
        countryCodeOk = check_country_code stripedRawCode
        code = makeCountryCode (read stripedRawCode::Integer)
        phoneNum = makePhoneNo (read rawPhoneNum::Integer)

-- This function will strip '+' or "00" in the beginning if present
strip_initials :: String -> String
strip_initials "" = ""
strip_initials [a, b]
    | a == '+' = [b]
    | a == '0' && b == '0' = ""
    | otherwise = [a, b]
strip_initials (x:y:xs)
    | x == '+' = y:xs
    | x == '0' && y == '0' = xs
    | otherwise = x:y:xs

check_country_code :: String -> Bool
check_country_code s = s `elem` ["358", "84", "1", "60"]

-- End the code from task 2 and 3

-- Actual source code for task 4 here
type Name = String

data PhoneBookEntry = PhoneBookEntry {
    name :: Name
    ,phone :: Phone
} deriving (Show, Eq)

find_entry_by_name :: [PhoneBookEntry] -> Name -> [PhoneBookEntry]
find_entry_by_name [] _ = []
find_entry_by_name entries n = [entry | entry <- entries, name entry == n]

find_entry_by_phoneNo :: [PhoneBookEntry] -> String -> [PhoneBookEntry]
find_entry_by_phoneNo [] _ = []
find_entry_by_phoneNo entries n = [entry | entry <- entries, phoneNo (phone entry) == makePhoneNo (read n::Integer)]

insert_new_entry :: Name -> String -> String -> String -> [PhoneBookEntry] -> [PhoneBookEntry]
insert_new_entry n rawPhoneType rawCode rawPhoneNum phoneBook = phoneBook ++ new_entry
    where
        find_entry_by_name_and_phoneNo = find_entry_by_phoneNo (find_entry_by_name phoneBook n) rawPhoneNum
        new_entry = if length find_entry_by_name_and_phoneNo == 0   then [PhoneBookEntry {name = n, phone = readPhone rawPhoneType rawCode rawPhoneNum }] else []   

entries = [PhoneBookEntry "entry1" (Phone WorkLandline  (CountryCode 111) (PhoneNo 121212) ),
           PhoneBookEntry "entry2" (Phone PrivateMobile (CountryCode 222) (PhoneNo 232323) ),
           PhoneBookEntry "entry3" (Phone WorkMobile    (CountryCode 333) (PhoneNo 343434) ),
           PhoneBookEntry "entry4" (Phone Other         (CountryCode 444) (PhoneNo 454545) ),
           PhoneBookEntry "entry5" (Phone Other         (CountryCode 555) (PhoneNo 565656) ),
           PhoneBookEntry "entry6" (Phone WorkLandline  (CountryCode 666) (PhoneNo 676767) )
           ]        