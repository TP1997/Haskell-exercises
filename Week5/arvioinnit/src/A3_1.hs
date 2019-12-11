module A3_1 where

-- Functions for task 5.3 are findPhoneFromPhoneBook and addPhone

import Data.Char
import qualified Data.Map as Map

countryCodes = [ "0", "1", "20", "210", "211", "212", "213", "214", "215", "216", "217", "218", "219", "220", "221", "222", "223", "224", "225", "226", "227", "228", "229", "230", "231", "232", "233", "234", "235", "236", "237", "238", "239", "240", "241", "242", "243", "244", "245", "246", "247", "248", "249", "250", "251", "252", "253", "254", "255", "256", "257", "258", "259", "260", "261", "262", "263", "264", "265", "266", "267", "268", "269", "27", "280", "281", "282", "283", "284", "285", "286", "287", "288", "289", "290", "291", "292", "293", "294", "295", "296", "297", "298", "299", "30", "31", "32", "33", "34", "350", "351", "352", "353", "354", "355", "356", "357", "358", "359",
                   "36", "370", "371", "372", "373", "374", "375", "376", "377", "378", "379", "380", "381", "382", "383", "384", "385", "386", "387", "388", "389", "39", "40", "41", "420", "421", "422", "423", "424", "425", "426", "427", "428", "429", "43", "44", "45", "46", "47", "48", "49", "500", "501", "502", "503", "504", "505", "506", "507", "508", "509", "51", "52", "53", "54", "55", "56", "57", "58", "590", "591", "592", "593", "594", "595", "596", "597", "598", "599", "60", "61", "62", "63", "64", "65", "66", "670", "671", "672", "673", "674", "675", "676", "677", "678", "679", "680", "681", "682", "683", "684", "685", "686", "687", "688", "689", "690", "691", "692", "693", "694", "695",
                   "696", "697", "698", "699", "800", "801", "802", "803", "804", "805", "806", "807", "808", "809", "81", "82", "830", "831", "832", "833", "834", "835", "836", "837", "838", "839", "84", "850", "851", "852", "853", "854", "855", "856", "857", "858", "859", "86", "870", "871", "872", "873", "874", "875", "876", "877", "878", "879", "880", "881", "882", "883", "884", "885", "886", "887", "888", "889", "890", "891", "892", "893", "894", "895", "896", "897", "898", "899", "90", "91", "92", "93", "94", "95", "960", "961", "962", "963", "964", "965", "966", "967", "968", "969", "970", "971", "972", "973", "974", "975", "976", "977", "978", "979", "98", "990", "991", "992", "993",
                   "994", "995", "996", "997", "998", "999" ]

data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Show, Eq, Read)

data CountryCode = CountryCode { countrycode :: Int  
                     } deriving (Eq)

instance Show CountryCode where  
        show (CountryCode countrycode) = "+" ++ show countrycode

createCountryCode :: Int -> CountryCode
createCountryCode cc 
    | cc < 0 = error "Country code must be positive!"
    | otherwise = CountryCode { countrycode=cc }

data PhoneNo = PhoneNo { phoneno :: Int  
                     } deriving (Eq)

instance Show PhoneNo where  
        show (PhoneNo phoneno) = show phoneno


data Phone = Phone { phoneType :: PhoneType  
                     , countryCode :: CountryCode  
                     , phoneNo :: PhoneNo  
                     } deriving (Eq)

instance Show Phone where  
        show (Phone phoneType countryCode phoneNo) = show countryCode ++ " " ++ show phoneNo ++ " (" ++ show phoneType ++ ")"


createPhone :: PhoneType -> CountryCode -> PhoneNo -> Phone
createPhone pt cc pn = Phone { phoneType=pt, countryCode=cc, phoneNo=pn }

stringToInteger s = read s :: Int

readPhoneType s = read s :: PhoneType

readCountryCode :: String -> CountryCode
readCountryCode cc
    | head cc == '+' = readCountryCode (tail cc)
    | take 2 cc == "00" = readCountryCode (drop 2 cc)
    | elem cc countryCodes == True = createCountryCode (stringToInteger cc)
    | otherwise = error "Invalid country code!"

readPhone :: String -> String -> String -> Phone
readPhone pt cc pn
    | pt /= "WorkLandline" && pt /= "PrivateMobile" && pt /= "WorkMobile" && pt /= "Other" =  error "Invalid phone type!"
    | all isDigit pn == False = error "Invalid phone number!"
    | otherwise = createPhone (readPhoneType pt) (readCountryCode cc) (PhoneNo (stringToInteger pn))

type Name = String
type PhoneBook = Map.Map [(Name,Phone)]

puhelin1 = readPhone "PrivateMobile" "+358" "040123456"
puhelin2 = readPhone "PrivateMobile" "+358" "040100200"
puhelin3 = readPhone "PrivateMobile" "+358" "050200300"
puhelin4 = readPhone "PrivateMobile" "+358" "050300400"

phoneBook = Map.fromList [("Antti",puhelin1), ("Antti",puhelin2), ("Kalle",puhelin3), ("Erkki",puhelin3)]

findPhone s p = Map.lookup s p

-- Usage example: findPhoneFromPhoneBook "Name"

findPhoneFromPhoneBook :: String -> Maybe Phone
findPhoneFromPhoneBook s = findPhone s phoneBook

-- Usage example: addPhone "Test" "Other" "998" "213123" phoneBook

addPhone n pt cc pn pb = Map.insert n (readPhone pt cc pn) pb

--let entries1 = insertNewEntry  "entry7" "WorkLandline"  "358"  "77777" phoneBook
--findEntry "entry7" entries1