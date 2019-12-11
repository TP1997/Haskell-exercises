module Functions2 where

import Definitions2

-- Helper functions reading input.
readItgr :: String -> Maybe Integer
readItgr s = case reads s of
             [(val, "")] -> Just val
             _           -> Nothing

stringToItgr :: String -> Integer
stringToItgr s = case readItgr s of
                 Just val -> val
                 Nothing  -> error ("Error! Can't convert " ++ s ++ " to Integer.")

------------------------CountryCode Show-instance & related functions.-----------------------------------
instance Show CountryCode where
    show (CountryCode cc) = "+" ++ show cc

--Country code creator with value testing.
createCountryCode :: Integer -> Maybe CountryCode
createCountryCode cci
        | cci<0      = error "Negative country code!"
        | otherwise = Just (CountryCode cci)    

--Parse country code out of string.
parseCC :: String -> Maybe CountryCode
parseCC []  = Nothing
parseCC ccs = checkCodeTable $ stringToItgr $ removedPrefix ccs
            where removedPrefix ('+':s)     = s
                  removedPrefix ('0':'0':s) = s
                  removedPrefix s           = s

--Check if given country code is included into supported country codes.
checkCodeTable :: Integer -> Maybe CountryCode
checkCodeTable cc
               | cc `elem` ccList = createCountryCode cc
               | otherwise        = error "Error! Given country code not in the supported list."    
               
------------------------PhoneNo Show-instance & related functions----------------------------------------  
instance Show PhoneNo where
    show (PhoneNo pn) = show pn

--Phone number creator with value testing.
createPhoneNo :: Integer -> Maybe PhoneNo
createPhoneNo pni
        | pni<0     = error "Negative phone number!"
        | otherwise = Just (PhoneNo pni)

--Parse phone number out of string.
parsePN :: String -> Maybe PhoneNo
parsePN []  = Nothing
parsePN pns = createPhoneNo $ stringToItgr pns

------------------------Phone Show-instance--------------------------------------------------------------
instance Show Phone where
    show (Phone pt Nothing Nothing)     = "null null ("++show pt++")"
    show (Phone pt (Just cc) Nothing)   = show cc++" null ("++show pt++")"
    show (Phone pt Nothing (Just pn))   = "null "++show pn++" ("++show pt++")"
    show (Phone pt (Just cc) (Just pn)) = show cc++" "++show pn++" ("++show pt++")"


------------------------readPhone-function---------------------------------------------------------------
readPhone :: String -> String -> String -> Phone
readPhone pts ccs pns = let pt  = read pts :: PhoneType
                            cc  = parseCC ccs
                            pn  = parsePN pns
                        in Phone pt cc pn

--Example usage:
-- readPhone "Other"         "358"   "11111"
-- readPhone "WorkLandline"  "+500"  "22222"
-- readPhone "PrivateMobile" ""      "33333"
-- readPhone "WorkMobile"    "00387" ""                        