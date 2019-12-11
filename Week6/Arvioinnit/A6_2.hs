module A6_2 where

import Data.Maybe ( fromJust )

data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving(Show, Read, Eq)

newtype CountryCode  = MakeCountryCode Integer deriving(Eq,Read)    --newtype
newtype PhoneNo      = MakePhoneNo Integer deriving(Eq,Read)        --newtype
data Phone           = MakePhone {phoneType   :: Maybe PhoneType    --Maybe
                                 ,countryCode :: Maybe CountryCode  --Maybe
                                 ,phoneNo     :: PhoneNo    
                                 } deriving(Eq, Read)

availableCountryCodes = ["358", "359", "41", "84"]
toCountryCode :: Integer -> CountryCode
toCountryCode x 
  | x < 0 = error "Invalid country code."
  --Moved the availability check here for convenience.
  | not $ (show x) `elem` availableCountryCodes = error "Country code not available."
  | otherwise = MakeCountryCode x
                  
toPhoneNo :: Integer -> PhoneNo
toPhoneNo x 
  | x < 0 = error "Invalid phone number."
  | otherwise = MakePhoneNo x
              
toPhone ::   Maybe PhoneType      --Maybe
          -> Maybe CountryCode    --Maybe
          -> PhoneNo
          -> Phone
toPhone pt cc pn = MakePhone pt cc pn

instance Show CountryCode where
  show (MakeCountryCode x) = '+' : show x

instance Show PhoneNo where
  show (MakePhoneNo x) = show x

instance Show Phone where
  --Pattern matching the new value constructor.
  show (MakePhone Nothing Nothing pn)     = show pn
  show (MakePhone Nothing (Just cc) pn)   = show cc ++ " "  ++ show pn
  show (MakePhone (Just pt) Nothing pn)   = show pn ++ " (" ++ show pt ++ ")"
  show (MakePhone(Just pt) (Just cc) pn)  = show cc ++ " "  ++ show pn ++ " (" ++ show pt ++ ")"


--start of 6.1
readMaybe :: (Read a) => String -> Maybe a  
readMaybe st = case reads st of [(x,"")] -> Just x  
                                _ -> Nothing

readPhone :: String
          -> String 
          -> String
          -> Phone
readPhone ptStr ccStr pnStr
  |(readMaybe ccStr :: Maybe Integer) == Nothing = toPhone (readMaybe ptStr :: Maybe PhoneType) Nothing (toPhoneNo(read pnStr :: Integer))
  |otherwise = toPhone (readMaybe ptStr :: Maybe PhoneType) ((Just (toCountryCode (read ccStr :: Integer)))) (toPhoneNo(read pnStr :: Integer))

--for testing:
--readPhone "" "" "12345"
--readPhone "Other" "" "12345"
--readPhone "Other" "358" "12345"