module A1_1 where
-- Functional programming I 2019 - Task 5.1
-- Test example: readPhone "" "" "123456789"

data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving(Show, Eq, Read)
newtype CountryCode  = MakeCountryCode Integer deriving(Eq,Read)
newtype PhoneNo      = MakePhoneNo Integer deriving(Eq,Read)
data Phone        = MakePhone {phoneType   :: Maybe PhoneType
                              ,countryCode :: Maybe CountryCode
                              ,phoneNo     :: PhoneNo
                              } deriving(Eq, Read)

toCountryCode :: Integer -> CountryCode
toCountryCode x | x < 0 = error "Invalid country code."
                | otherwise = MakeCountryCode x

toPhoneNo :: Integer -> PhoneNo
toPhoneNo x | x < 0 = error "Invalid phone number."
            | otherwise = MakePhoneNo x

toPhone :: Maybe PhoneType
          -> Maybe CountryCode
          -> PhoneNo
          -> Phone
toPhone pt cc pn = MakePhone pt cc pn

instance Show CountryCode where
  show (MakeCountryCode x) = '+' : show x

instance Show PhoneNo where
  show (MakePhoneNo x) = show x

instance Show Phone where
  show (MakePhone Nothing Nothing pn) = show pn
  show (MakePhone Nothing (Just cc) pn) = show cc ++ " "++show pn
  show (MakePhone (Just pt) Nothing pn) = show pn ++ " (" ++ show pt ++ ")"
  show (MakePhone (Just pt) (Just cc) pn) = show cc ++ " "++ show pn ++ " (" ++ show pt ++ ")"

allowedCountryCodes = ["358", "359", "41", "84"]

readCountryCode :: String -> CountryCode
readCountryCode (a:b:xs)
  | [a,b] == "00" = readCountryCode xs
  | a == '+' = readCountryCode (b:xs)
  | not $ (a:b:xs) `elem` allowedCountryCodes = error "Country code not found."
  | otherwise = toCountryCode $ read (a:b:xs)

readPhone :: String -> String -> String -> Phone
readPhone pt cc pn
  | pt == "" && cc == "" =
    toPhone Nothing Nothing (toPhoneNo (read pn :: Integer))
  | pt == "" =
    toPhone Nothing (Just (toCountryCode (read cc :: Integer))) (toPhoneNo (read pn :: Integer))
  | cc == "" =
    toPhone (Just (read pt:: PhoneType)) Nothing (toPhoneNo (read pn :: Integer))

  | otherwise =
    toPhone (Just(read pt:: PhoneType)) (Just(toCountryCode (read cc :: Integer))) (toPhoneNo (read pn :: Integer))