module Phone.Definitions
( PhoneType
, CountryCode
,PhoneNo
,Phone
) where 

data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving(Show, Read, Eq)

--      +-- Type constructor
--      |
--      |               +--Value/data constructor
--      |               |
--      |               |  Type and value/data constructor could have the same name; They are in different namespaces.
--      v               v  It is conventional to name them the same, but now for clarity we name them differently.
newtype CountryCode  = MakeCountryCode Integer deriving(Eq,Read)
newtype PhoneNo      = MakePhoneNo Integer deriving(Eq,Read)
data Phone        = MakePhone {phoneType   :: Maybe PhoneType
                              ,countryCode :: Maybe CountryCode
                              ,phoneNo     :: PhoneNo    
                              } deriving(Eq, Read)
instance Show CountryCode where
  show (MakeCountryCode x) = '+' : show x
--           ^
--           |
--           +-- Pattern matching the value/data constructor.

-- Type constructor |
--                  |
--                  v
instance Show PhoneNo where
  show (MakePhoneNo x) = show x
--           ^
--           |
--           +-- Pattern matching the value/data constructor.
instance Show Phone where
  show phone 
    |show cc == "Nothing" && show pt == "Nothing" =show pn
    |show cc == "Nothing" = show pn ++ " (" ++ show pt ++ ")"
    |show pt == "Nothing" = show cc ++ " "++ show pn
    |otherwise = show cc ++ " "++ show pn ++ " (" ++ show pt ++ ")"
    where
      cc = countryCode phone
      pn = phoneNo phone
      pt = phoneType phone    