module Arviointi4_2 where

-- Task 4-2
-- While testing call for example: createPhone WorkLandline (addCountryCode 358) (addPhoneNo 123456789)
data PhoneType = WorkLandline | PrivateMobile  | WorkMobile  | Other deriving (Show, Eq, Read)
data CountryCode = CountryCode Int deriving (Eq)
data PhoneNo = PhoneNo Int deriving (Eq)

instance Show CountryCode where
    show (CountryCode a) = "+" ++ show a
    
instance Show PhoneNo where
    show (PhoneNo a) = show a

addCountryCode :: Int -> CountryCode
addCountryCode code
    | code < 0 = error "Countrycode can't be negative!"
    | otherwise = CountryCode code
    
addPhoneNo :: Int -> PhoneNo
addPhoneNo no
    | no < 0 = error "Phonenumber can't be negative!"
    | otherwise = PhoneNo no
    

data Phone = Phone { phoneType :: PhoneType, countryCode :: CountryCode, phoneNo :: PhoneNo} deriving (Eq)
                   
createPhone :: PhoneType -> CountryCode -> PhoneNo -> Phone
createPhone pt cc pn = Phone {phoneType = pt, countryCode = cc, phoneNo = pn}

instance Show Phone where
    show (Phone pt cc pn) = show cc ++ " " ++ show pn ++ " (" ++ show pt ++ ")"

--------------------------------- Task 4-3 --------------------------------------------
-- While testing call for example: readPhone "Other" "+358" "123456789"
countryCodes = ["356", "357", "358", "359"]

readPhone :: String -> String -> String -> Phone
readPhone pt cc pn = createPhone (read pt) (addCountryCode (read (ccOK cc))) (addPhoneNo (read pn))

ccOK :: String -> String
ccOK cc
    | head cc == '+' = drop 1 cc
    | head cc == '0' && (cc !! 1) == '0' = drop 2 cc
    | notElem cc countryCodes = error "Incorrect countrycode!"
    | otherwise = cc
    
--------------------------------- Task 4-4 ----------------------------------------------
data Entry = Entry {name :: String, phone :: Phone} deriving (Show, Eq)

searchPhonebook :: String -> [Entry] -> [Entry]
searchPhonebook n pb = filter(\entry -> n == name entry) pb

addToPhonebook :: String -> String -> String -> String -> [Entry] -> [Entry]
addToPhonebook n pt cc pn pb
    | (Entry n (readPhone pt cc pn)) `elem` pb = error "That combination already exists in the phonebook."
    | otherwise = pb ++ [Entry n (readPhone pt cc pn)]

entries = [Entry "entry1" (Phone WorkLandline  (CountryCode 111) (PhoneNo 121212) ),
           Entry "entry2" (Phone PrivateMobile (CountryCode 222) (PhoneNo 232323) ),
           Entry "entry3" (Phone WorkMobile    (CountryCode 333) (PhoneNo 343434) ),
           Entry "entry4" (Phone Other         (CountryCode 444) (PhoneNo 454545) ),
           Entry "entry5" (Phone Other         (CountryCode 555) (PhoneNo 565656) ),
           Entry "entry6" (Phone WorkLandline  (CountryCode 666) (PhoneNo 676767) )
           ]    