module Testspace where

-- Helper functions reading input
readItgr :: String -> Maybe Integer
readItgr s = case reads s of
             [(val, "")] -> Just val
             _           -> Nothing

stringToItgr :: String -> Integer
stringToItgr s = case readItgr s of
                 Just val -> val
                 Nothing  -> error ("Error! Can't convert " ++ s ++ " to Integer.")

{- ################################## PhoneType datatype ############################################################ -}
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Eq, Show, Read)

{- ################################## CountryCode-datatype & some related functions ################################## -}
data CountryCode = CountryCode Integer deriving(Eq, Read)
instance Show CountryCode where
    show (CountryCode cc) = "+" ++ show cc

--Country code creator with value testing.
createCountryCode :: Integer -> CountryCode
createCountryCode cc
        | cc<0      = error "Negative country code!"
        | otherwise = CountryCode cc

--Parse country code out of string.
parseCC :: String -> CountryCode
parseCC []  = error "Error! Empty string given as country code."
parseCC ccs = if ccs!!0 == '+' then
                 checkCodeTable $ stringToItgr $ drop 1 ccs
              else if take 2 ccs == "00" then
                 checkCodeTable $ stringToItgr $ drop 2 ccs
              else 
                 checkCodeTable $ stringToItgr ccs

--Check if given country code is included into supported country codes.
checkCodeTable :: Integer -> CountryCode
checkCodeTable cc
               | not $ cc `elem` ccList = error "Error! Given country code not in the supported list."
               | otherwise              = createCountryCode cc

--List of supported country codes.
ccList = [ 358,
           500,
           298,
           33,
           594,
           49,
           30,
           387
         ]

{- ################################## PhoneNo datatype & some related functions ##################################### -}
data PhoneNo = PhoneNo Integer deriving(Eq, Read)
instance Show PhoneNo where
    show (PhoneNo pn) = show pn

--Phone number creator with value testing.
createPhoneNo :: Integer -> PhoneNo
createPhoneNo pn
        | pn<0      = error "Negative phone number!"
        | otherwise = PhoneNo pn

--Parse phone number out of string.
parsePN :: String -> PhoneNo
parsePN [] = error "Error! Empty string given as phone number."
parsePN pns = createPhoneNo $ stringToItgr pns 

{- ################################### Phone-datatype & Show instance              ################################# -}
data Phone = Phone{phoneType :: PhoneType, countryCode :: CountryCode, phoneNo :: PhoneNo} deriving (Eq, Read)                   
instance Show Phone where
    show (Phone pt cc pn) = show cc++" "++show pn++" ("++show pt++")"  

{- ################################### BookEntry-datatype                          ################################# -}
data BookEntry = BookEntry {name :: String, phone :: Phone} deriving (Eq, Read)
instance Show BookEntry where
    show (BookEntry name phone) = show name++" : "++show phone

--(Test) List of book entries:
entries = [BookEntry "entry1" (Phone WorkLandline (CountryCode 111) (PhoneNo 121212) ) ,
           BookEntry "entry2" (Phone PrivateMobile (CountryCode 222) (PhoneNo 232323) ),
           BookEntry "entry3" (Phone WorkMobile (CountryCode 333) (PhoneNo 343434) )   ,
           BookEntry "entry4" (Phone Other (CountryCode 444) (PhoneNo 454545) )        ,
           BookEntry "entry5" (Phone Other (CountryCode 555) (PhoneNo 565656) )        ,
           BookEntry "entry6" (Phone WorkLandline (CountryCode 666) (PhoneNo 676767) )
           ]  

{- #################################### Functions                                  ################################## -} 
--Find book entry from given list of entries.
findEntry :: String -> [BookEntry] -> [BookEntry]
findEntry s entries = filter (\entry -> (name entry)==s) entries  --Yksinkertaista syntaksia!

--Add book entry to given list
addEntry :: String -> String -> String -> String -> [BookEntry] -> [BookEntry]
addEntry s pts ccs pns entries 
                | s `elem` (map name entries) || pn `elem` (map phoneNo $ map phone entries) = entries
                | otherwise                 = (BookEntry s (Phone pt cc pn)):entries
                where pt = read pts :: PhoneType
                      cc = parseCC ccs
                      pn = parsePN pns

{- ################################### Debugging ################################################################### -}
{-
                  (pass & found/not found)
let entries1 = addEntry  "entry7" "WorkLandline"  "358"  "77777" entries  --> pass
findEntry "entry7" entries1                                               --> found

let entries2 = addEntry  "entry8" "WorkLandline"  "+500" "88888" entries  --> pass
findEntry "entry8" entries2                                               --> found

let entries3 = addEntry  "entry9" "PrivateMobile" "0033" "99999" entries  --> pass
findEntry "entry9" entries3                                               --> found

let entries4 = addEntry  "entry9" "WorkMobile"    "387"  "121212" entries --> pass
findEntry "entry9" entries4                                               --> not found

let entries5 = addEntry  "test"   "Other"         "358"  "11111" []       --> pass
findEntry "test" entries5                                                 --> found

                 (should give error)
addEntry "test" "Otherxd"         "358"   "11111" entries                 --> err
addEntry "test" "WorkLandline"    "++500" "22222" entries                 --> err
addEntry "test" "PrivateMobile"   "00033" "33s33" entries                 --> err
addEntry "test" "WorkMobile"      ""      "44444" entries                 --> err
addEntry "test" "Other"           "358"   ""      entries                 --> err

-}                      
                                   