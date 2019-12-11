module Arviointi3_2 where

--EXAMPLE TEST:
--readPhone "WorkMobile" "+356" "0401234567"

data PhoneType = WorkLandLine | PrivateMobile | WorkMobile | Other deriving (Show, Eq, Read)

data CountryCode = CountryCode Integer deriving (Eq)
instance Show CountryCode where 
    show (CountryCode c) =  "+" ++ show(c)
countryCode:: Integer -> CountryCode
countryCode i
    | i < 0 = error "Negative country code!"
    | otherwise = CountryCode i

data PhoneNo = PhoneNo Integer deriving (Eq)
instance Show PhoneNo where 
    show (PhoneNo n) =  show n
phoneNo:: Integer -> PhoneNo
phoneNo i
    | i < 0 = error "Negative phone number!"
    | otherwise = PhoneNo i

data Phone = Phone{phoneT::PhoneType, countryC::CountryCode, phoneN::PhoneNo} deriving (Eq)
instance Show Phone where
    show (Phone pt cc pn) = show(show(cc) ++ " " ++ show(pn) ++ " " ++ show(pt))

func:: PhoneType -> CountryCode -> PhoneNo -> Phone
func pt cc pn = Phone pt cc pn

countries = [1, 2 .. 1000]

readPhone:: String -> String -> String -> Phone
readPhone pt cc pn = Phone (read pt::PhoneType) (readCountryCode cc) (phoneNo (read pn::Integer))

readCountryCode:: String -> CountryCode
readCountryCode (x:x2:xs)
    | x /= '+' = checkCountryCode (read (x:x2:xs)::Integer)
    | x == '0' && x2 == '0' = checkCountryCode (read (xs)::Integer)
    | otherwise = checkCountryCode (read (x2:xs)::Integer)

checkCountryCode:: Integer -> CountryCode
checkCountryCode cc
    | isInList cc countries = countryCode cc
    | otherwise = error "Bad country code! Valid numbers are 1 - 1000."

isInList _ [] = False
isInList s (x:xs)
    | s == x = True
    | otherwise = isInList s xs	