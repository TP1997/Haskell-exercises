module Funcs2 where

--Task 2
{- #################### PhoneType datatype                          ################################# -}
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Show, Eq, Read)

{- ################### CountryCode-datatype & some related functions ################################ -}
data CountryCode = CountryCode Integer deriving(Eq)

instance Show CountryCode where
    show (CountryCode cc) = "+" ++ show cc

makeCC :: Integer -> CountryCode
makeCC cc
    | cc<0      = error "Negative country code!"
    | otherwise = CountryCode cc

{- ################### PhoneNo datatype & some related functions    ################################ -}
data PhoneNo = PhoneNo Integer deriving(Eq)

instance Show PhoneNo where
    show (PhoneNo pn) = show pn

makePN :: Integer -> PhoneNo
makePN pn
    | pn<0      = error "Negative phone number!"
    | otherwise = PhoneNo pn

{- ################### Phone datatype & Show-instance               ################################ -}
data Phone = Phone{phoneType :: PhoneType, countryCode :: CountryCode, phoneNo :: PhoneNo} deriving (Eq)
instance Show Phone where
    show (Phone pt cc pn) = show cc++" "++show pn++" ("++show pt++")"

{- ################### Actual function (call this one)              ################################ -}
task2 :: PhoneType -> CountryCode -> PhoneNo -> Phone
task2 pt cc pn = Phone pt cc pn