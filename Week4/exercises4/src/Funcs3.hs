module Funcs3 where

{- ###################################################################################### 
Things to note:
In the assignment it was said that ... 
b) reads the country code code from the second string in the following way:
1. ...
2. check that the code exists in a predefined list of country codes 
   (you may define this as just a list of strings or a list of integers in your program)
3. read an integer out of the remaining string
4. ...
I kind of swapped parts 2 & 3. It doesn't affect to program performance so I think it's ok.
I also included presefined country-code-list that you may use.
 ######################################################################################### -}
-- Helper functions reading input
readItgr :: String -> Maybe Integer
readItgr s = case reads s of
             [(val, "")] -> Just val
             _           -> Nothing

stringToItgr :: String -> Integer
stringToItgr s = case readItgr s of
                 Just val -> val
                 Nothing  -> error ("Error! Can't convert <" ++ s ++ "> to Integer.") 

{- ################################## PhoneType datatype ############################################################ -}
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Eq, Show, Read)

{- ################################## CountryCode-datatype & some related functions ################################### -}
data CountryCode = CountryCode Integer deriving(Eq, Read)
instance Show CountryCode where
    show (CountryCode cc) = "+" ++ show cc

--Country code creator with value testing.
createCountryCode :: Integer -> CountryCode
createCountryCode cc
        | cc<0      = error "Negative country code!"
        | otherwise = CountryCode cc

--Parse country code out of string.
parseCC :: String -> CountryCode
parseCC []  = error "Error! Empty string given as country code."
parseCC ccs = if ccs!!0 == '+' then
                 checkCodeTable $ stringToItgr $ drop 1 ccs
              else if take 2 ccs == "00" then
                 checkCodeTable $ stringToItgr $ drop 2 ccs
              else 
                 checkCodeTable $ stringToItgr ccs

--Check if given country code is included into supported country codes.
checkCodeTable :: Integer -> CountryCode
checkCodeTable cc
               | not $ cc `elem` ccList = error "Error! Given country code not in the supported list."
               | otherwise              = createCountryCode cc

--List of supported country codes.
ccList = [ 358,
           500,
           298,
           33,
           594,
           49,
           30,
           387
         ]

{- ################################## PhoneNo datatype & some related functions ###################################### -}
data PhoneNo = PhoneNo Integer deriving(Eq, Read)
instance Show PhoneNo where
    show (PhoneNo pn) = show pn

--Phone number creator with value testing.
createPhoneNo :: Integer -> PhoneNo
createPhoneNo pn
        | pn<0      = error "Negative phone number!"
        | otherwise = PhoneNo pn

--Parse phone number out of string.
parsePN :: String -> PhoneNo
parsePN [] = error "Error! Empty string given as phone number."
parsePN pns = createPhoneNo $ stringToItgr pns 
         
{- ################################### Phone-datatype & Show instance              ################################# -}
data Phone = Phone{phoneType :: PhoneType, countryCode :: CountryCode, phoneNo :: PhoneNo} deriving (Eq, Read)                   
instance Show Phone where
    show (Phone pt cc pn) = show cc++" "++show pn++" ("++show pt++")"

{- ################################### readPhone-function ########################################################## -}
readPhone :: String -> String -> String -> Phone
readPhone pts ccs pns = let pt  = read pts :: PhoneType
                            cc  = parseCC ccs
                            pn  = parsePN pns
                        in Phone pt cc pn           

{- ################################### Debugging ################################################################### -}
{-

                  (should pass)
readPhone "Other"         "358"  "11111"  --> pass
readPhone "WorkLandline"  "+500" "22222"  --> pass
readPhone "PrivateMobile" "0033" "33333"  --> pass
readPhone "WorkMobile"    "387"  "44444"  --> pass
readPhone "Other"         "358"  "11111"  --> pass

                 (should fail)
readPhone "Otherxd"         "358"   "11111"  --> fail?
readPhone "WorkLandline"    "++500" "22222"  --> fail
readPhone "PrivateMobile"   "00033" "33s33"  --> fail
readPhone "WorkMobile"      ""      "44444"  --> fail
readPhone "Other"           "358"   ""       --> fail

-}

{-
{- ########################### PhoneType-datatype ################################## -}
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Eq, Show, Read)
{- ############################ CountryCode-datatype ################################ -}
data CountryCode = CountryCode Integer deriving(Eq, Read)
instance Show CountryCode where
    show (CountryCode cc) = "+" ++ show cc

makeCC :: Integer -> CountryCode
makeCC cc
    | cc<0      = error "Negative country code!"
    | otherwise = CountryCode cc
{- ############################ PhoneNo-datatype #################################### -}
data PhoneNo = PhoneNo Integer deriving(Eq, Read)

instance Show PhoneNo where
    show (PhoneNo pn) = show pn

makePN :: Integer -> PhoneNo
makePN pn
    | pn<0      = error "Negative phone number!"
    | otherwise = PhoneNo pn
{- ############################# Phone-datatype ##################################### -}
data Phone = Phone{phoneType :: PhoneType, countryCode :: CountryCode, phoneNo :: PhoneNo} deriving (Eq, Show, Read)

{- ################################## Function ###################################### -}
-- {-
parseCC :: String -> CountryCode
parseCC [] = error "Error! Invalid country code form."
parseCC ccs
        | (ccs!!1 == '+')            = parseCC $ drop 1 ccs --Muuta!!
        | (take 2 ccs == "00")       = parseCC $ drop 2 ccs --Muuta!!
        | not $ ccs `elem` cntrCodes = error "Error! Given country code not in the supported list."
        | otherwise                  = makeCC (read ccs :: Integer)
-- -} 
-- {-
parsePN :: String -> PhoneNo
parsePN pns = makePN (read pns :: Integer)
-- -}
 -- {-
task3 :: String -> String -> String -> Phone
task3 pts ccs pns = let pt  = read pts :: PhoneType
                        cc  = parseCC ccs
                        pn = parsePN pns
                    in Phone pt cc pn

 -- -}

cntrCodes = [ "358",
              "500",
              "298",
              "33",
              "594",
              "49",
              "30",
              "387"
            ]        

--"Phone{phoneType="\"++pt++""\, countryCode="\"++cc++""\, phoneNo="\"++pn++""\}""
--"Phone{phoneType=Other, countryCode=358, phoneNo=123456}" :: Phone
--read pt :: PhoneType
--read ("CountryCode " ++ cc) :: CountryCode
--read ("PhoneNo " ++ pn) :: PhoneNo
-}