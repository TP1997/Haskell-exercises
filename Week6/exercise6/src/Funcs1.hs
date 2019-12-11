module Funcs1 where

readMaybe :: (Read a) => String -> Maybe a
readMaybe s = case reads s of
             [(x, "")] -> Just x
             _         -> Nothing   

------------------------------------Data definitions--------------------------------------------------
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Eq, Show, Read)

newtype CountryCode = CountryCode Integer deriving(Eq, Read)
newtype PhoneNo = PhoneNo Integer deriving(Eq, Read)
data Phone = Phone{ phoneType   :: Maybe PhoneType
                   ,countryCode :: Maybe CountryCode
                   ,phoneNo     :: PhoneNo} deriving (Eq, Read)

--List of supported country codes.
ccList = ["358", "359", "41", "84"]                   
------------------------------------Instances---------------------------------------------------------
instance Show CountryCode where
    show (CountryCode cc) = "+" ++ show cc

instance Show PhoneNo where
    show (PhoneNo pn) = show pn

instance Show Phone where
    show (Phone Nothing Nothing pn)     = show pn
    show (Phone Nothing (Just cc) pn)   = show cc++" "++show pn
    show (Phone (Just pt) Nothing pn)   = show pn++" ("++show pt++")"
    show (Phone (Just pt) (Just cc) pn) = show cc++" "++show pn++" ("++show pt++")"  

------------------------------------Other functions---------------------------------------------------
toPhoneNo :: Integer -> PhoneNo
toPhoneNo pni
  | pni < 0 = error "Invalid phone number."
  | otherwise = PhoneNo pni

toCountryCode :: Maybe Integer -> Maybe CountryCode
toCountryCode (Just cci)
    | cci < 0   = error "Invalid country code."
    | not $ (show cci) `elem` ccList = error "Country code not available."
    | otherwise = Just (CountryCode cci)
toCountryCode _ = Nothing    

toPhone :: Maybe PhoneType -> Maybe CountryCode -> PhoneNo -> Phone
toPhone pt cc pn = Phone pt cc pn

------------------------------------readPhone-function------------------------------------------------
readPhone :: String -> String -> String -> Phone
readPhone pts ccs pns = let pt  = readMaybe pts :: Maybe PhoneType
                            ccs' = removePrefix ccs
                                where removePrefix ('+':xs) = xs
                                      removePrefix ('0':'0':xs) = xs
                                      removePrefix xs = xs

                            cc = toCountryCode (readMaybe ccs' :: Maybe Integer)
                            pn = toPhoneNo $ read pns
                        in Phone pt cc pn
                            
--examples
-- readPhone "Other" "358" "11111"
-- readPhone "WorkLandline" "+358" "22222"
-- readPhone "PrivateMobile" "" "33333"
-- readPhone "" "00358" "4444"