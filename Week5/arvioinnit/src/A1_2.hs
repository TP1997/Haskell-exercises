module A1_2 where

import Data.Maybe

-- TASK 4.2
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other
    deriving (Show, Eq, Read)

data CountryCode = CountryCode Int deriving(Eq)
data PhoneNo = PhoneNo Int deriving(Eq)

instance Show CountryCode where
    show (CountryCode c) = "+" ++ show c

instance Show PhoneNo where
    show (PhoneNo n) = show n

createCC :: Int -> CountryCode
createCC c
    | c < 0 = error "Country Code cannot be negative!"
    | otherwise = CountryCode c

createPN :: Int -> PhoneNo
createPN n
    | n < 0 = error "Phone number cannot be negative!"
    | otherwise = PhoneNo n

    
-- TASK 5.1
-- Example input: readPhone "Other" "+358" "12345"
data Phone = Phone {phoneType :: Maybe PhoneType,
                    countryCode :: Maybe CountryCode,
                    phoneNo :: PhoneNo}
                    deriving (Eq)

instance Show Phone where
    show (Phone t c n) = exists c ++ " " ++ show n ++ " (" ++ exists t ++ ")"
                        where exists x = if x == Nothing then "" else show $ fromJust x

createPhone :: Maybe PhoneType -> Maybe CountryCode -> PhoneNo -> Phone
createPhone (Just t) c n = Phone {phoneType= Just t, countryCode=c, phoneNo=n}
createPhone t c n = Phone {phoneType=t, countryCode=c, phoneNo=n}

availableCountryCodes = ["358", "359", "41", "84"]

readPhone :: String
          -> String 
          -> String
          -> Phone
readPhone ptStr ccStr pnStr = 
  let pt = if ptStr == "" then Nothing else Just (read ptStr :: PhoneType) -- The derived Read instance makes the read function read a value out of string which is formatted the same as using show with derived instance for Show. (There could also be parentheses around it e.g. "(((WorkLandline)))" would read the same value as "WorkLandline")
      ccStr' = removePrefix ccStr --Note that the implementation of this function is right below inside the where clause.
        where removePrefix ('+':xs) = xs
              removePrefix ('0':'0':xs) = xs
              removePrefix xs = xs
      cc = if ccStr == "" then Nothing else Just (createCC $ read ccStr')
      pn = createPN $ read pnStr
  in case ccStr' `elem` availableCountryCodes of
    True  -> createPhone pt cc pn
    False -> error "Unknown country code!"