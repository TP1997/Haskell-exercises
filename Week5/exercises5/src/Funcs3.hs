module Funcs3 where

import qualified Data.Map as Map
-------------------------------Data definitions---------------------------------------------------------
--PhoneType-datatype
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Eq, Show, Read)

--CountryCode-datatype
data CountryCode = CountryCode Integer deriving(Eq, Read)

--PhoneNo-datatype
data PhoneNo = PhoneNo Integer deriving(Eq, Read)

--Phone-datatype
data Phone = Phone{phoneType :: PhoneType, countryCode :: CountryCode, phoneNo :: PhoneNo} deriving (Eq, Read)

--List of supported country codes.
ccList = [ 358,500,298,33,594,49,30,387]

--Map of predefined book entries.
mapEntries = Map.fromList [( "entry1", Phone WorkLandline  (CountryCode 111) (PhoneNo 121212) ),
                           ( "entry2", Phone PrivateMobile (CountryCode 222) (PhoneNo 232323) ),
                           ( "entry3", Phone WorkMobile    (CountryCode 333) (PhoneNo 343434) ),
                           ( "entry4", Phone Other         (CountryCode 444) (PhoneNo 454545) ),
                           ( "entry5", Phone Other         (CountryCode 555) (PhoneNo 565656) ),
                           ( "entry6", Phone WorkLandline  (CountryCode 666) (PhoneNo 676767) )
                          ] 
-------------------------------Helper functions reading input-------------------------------------------
readItgr :: String -> Maybe Integer
readItgr s = case reads s of
             [(val, "")] -> Just val
             _           -> Nothing

stringToItgr :: String -> Integer
stringToItgr s = case readItgr s of
                 Just val -> val
                 Nothing  -> error ("Error! Can't convert " ++ s ++ " to Integer.")

-------------------------------CountryCode Show-instance & related functions.---------------------------
instance Show CountryCode where
    show (CountryCode cc) = "+" ++ show cc

--Country code creator with value testing.
createCountryCode :: Integer -> CountryCode
createCountryCode cci
        | cci<0      = error "Negative country code!"
        | otherwise  = CountryCode cci

--Parse country code out of string.
parseCC :: String -> CountryCode
parseCC []  = error "Error! Empty string given as country code."
parseCC ccs = checkCodeTable $ stringToItgr $ removedPrefix ccs
            where removedPrefix ('+':s)     = s
                  removedPrefix ('0':'0':s) = s
                  removedPrefix s           = s

--Check if given country code is included into supported country codes.
checkCodeTable :: Integer -> CountryCode
checkCodeTable cc
               | cc `elem` ccList = createCountryCode cc
               | otherwise        = error "Error! Given country code not in the supported list."                  

-------------------------------PhoneNo Show-instance & related functions--------------------------------
instance Show PhoneNo where
    show (PhoneNo pn) = show pn

--Phone number creator with value testing.
createPhoneNo :: Integer -> PhoneNo
createPhoneNo pni
        | pni<0      = error "Negative phone number!"
        | otherwise = PhoneNo pni

--Parse phone number out of string.
parsePN :: String -> PhoneNo
parsePN []  = error "Error! Empty string given as phone number."
parsePN pns = createPhoneNo $ stringToItgr pns      
      
-------------------------------Phone Show-instance------------------------------------------------------
instance Show Phone where
    show (Phone pt cc pn) = show cc++" "++show pn++" ("++show pt++")"

-------------------------------User functions-----------------------------------------------------------
--Function which search book entries from map via book's name.
--Since map can hold only unique key values (in this case, book names), the function returns...
--If found:
--  Tuple (String, Maybe Phone), where first param is book's name and second Just Phone.
--If not found:
--  Tuple (String, Nothing)
findEntry :: String -> Map.Map String Phone -> (String, Maybe Phone)              
findEntry s entries = (s, Map.lookup s entries)

addEntry :: String -> String -> String -> String -> Map.Map String Phone -> Map.Map String Phone
addEntry s pts ccs pns entries
                | pns `elem` (map show $ map phoneNo $ Map.elems entries) = entries
                | otherwise = Map.insert s (Phone pt cc pn) entries
                where pt = read pts :: PhoneType
                      cc = parseCC ccs
                      pn = parsePN pns       

--Example usage:
--let entries1 = addEntry  "entry7" "WorkLandline"  "358"  "77777" mapEntries
--findEntry "entry7" entries1                                               

