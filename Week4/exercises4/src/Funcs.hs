module Funcs where

--Task 1
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Show, Eq, Read)

type CountryCode = Int
type PhoneNo = Int

data Phone = Phone{phoneType :: PhoneType, countryCode :: CountryCode, phoneNo :: PhoneNo} deriving (Show, Eq, Read)

task1 :: PhoneType -> CountryCode -> PhoneNo -> Phone
task1 pt cc pn
        | cc < 0 || pn < 0 = error "Negative country code or phone number!"
        | otherwise        = Phone pt cc pn

