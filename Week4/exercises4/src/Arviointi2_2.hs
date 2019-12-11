module Arviointi2_2 where

data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Show, Eq)

data CountryCode = CountryCode Integer deriving(Eq)
instance Show CountryCode where
   show(CountryCode x) = "+"++(show x)

createCc :: Integer -> CountryCode
createCc x
   | x < 0 = error "invalid country code"
   | otherwise = CountryCode x

data PhoneNo = PhoneNo Integer deriving(Eq)
instance Show PhoneNo where
   show(PhoneNo x) = show x

createPn :: Integer -> PhoneNo
createPn x
   | x < 0 = error "invalid phone number"
   | otherwise = PhoneNo x

data Phone = Phone { phoneType::PhoneType
                   , countryCode::CountryCode
                   , phoneNo::PhoneNo
                   } deriving(Eq)
instance Show Phone where
   show(Phone pt cc pn) = (show cc) ++ " " ++ (show pn) ++ " (" ++ (show pt) ++ ")"
createPhone :: PhoneType -> CountryCode -> PhoneNo -> Phone
createPhone pt cc pn = Phone pt cc pn

{- To test this code, load up this module into ghci, then you can for example try:
      
	  createPhone WorkLandline (createCc 358) (createPn 400578044)
      or createPhone WorkLandline (createCc (-368)) (createPn 403551057)	  
	  
	  the first one should work just fine
	  and the second one should throw an error because of the negative country code
-}