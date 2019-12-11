module Arviointi1 where

-- Task 4.1

data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other
  deriving (Eq, Read, Show)

type CountryCode = Integer
type PhoneNo = Integer

data Phone =
  Phone { phoneType :: PhoneType
        , countryCode :: CountryCode
        , phoneNo :: PhoneNo
        } deriving (Eq, Read, Show)

mkPhone :: PhoneType -> CountryCode -> PhoneNo -> Phone
mkPhone pType cCode pNo
  | cCode >= 0 && pNo >= 0 = Phone pType cCode pNo
  | otherwise = error "Phone constructor given a negative parameter."

constr :: PhoneType -> CountryCode -> PhoneNo -> Phone
constr x y z = if y < 0 || z < 0
               then error "negative inputs"
               else Phone x y z  