module Arviointi2 where

-- Imported from task 4.1
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Show, Eq, Read)
-- End of task 4.1

data CountryCode = MakeCode Integer deriving (Eq)
data PhoneNo = MakePhoneNo Integer deriving (Eq)

instance Show CountryCode where
    show (MakeCode zip) = "+" ++ show zip

instance Show PhoneNo where
    show (MakePhoneNo num) = show num

toCC :: Integer -> CountryCode
toCC cc
    | cc < 0 = error "Negative Country Code."
    | otherwise = MakeCode cc

toPhoneNo :: Integer -> PhoneNo
toPhoneNo num
    | num < 0 = error "Negative Phone Number."
    | otherwise = MakePhoneNo num

data Phone = Phone { phoneType :: PhoneType, countryCode :: CountryCode, phoneNo :: PhoneNo} deriving (Eq)

instance Show Phone where
    show (Phone {phoneType = p, countryCode = c, phoneNo = pn}) = (show c) ++ " " ++ (show pn) ++ " (" ++ (show p) ++ ")"

makePhone :: PhoneType -> Integer -> Integer -> Phone
makePhone typ zip num = Phone typ (toCC zip) (toPhoneNo num)
-- When creating an instance of Phone, it is best to put the parameters in brackets,
-- since Haskell easily mistakes the negative sign with the minus operation.

-- From what I understand, the functions toCC and toPhoneNo have the form Integer -> _,
-- therefore the parameters in toPhone have to be Integers so that the function can work.
-- That is why I used Integer here instead of what the prompt asked.	