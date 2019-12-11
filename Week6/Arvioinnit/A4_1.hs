module A4_1 where

import System.IO

-- Phonebook
-- From task 5.3
import qualified Data.Map as Map

-- Based on example answers of 4.2, 4.3 and 4.4
-- 4.2
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving(Show, Read, Eq)

data CountryCode  = MakeCountryCode Integer deriving (Eq, Read)
data PhoneNo      = MakePhoneNo Integer deriving (Eq, Read)
data Phone        = MakePhone { phoneType :: PhoneType, countryCode :: CountryCode, phoneNo :: PhoneNo } deriving (Eq, Read)

toCountryCode :: Integer -> CountryCode
toCountryCode x
  | x < 0 = error "Invalid country code."
  | otherwise = MakeCountryCode x

toPhoneNo :: Integer -> PhoneNo
toPhoneNo x
  | x < 0 = error "Invalid phone number."
  | otherwise = MakePhoneNo x
              
toPhone :: PhoneType -> CountryCode -> PhoneNo -> Phone
toPhone pt cc pn = MakePhone pt cc pn

instance Show CountryCode where
  show (MakeCountryCode x) = '+' : show x

instance Show PhoneNo where
  show (MakePhoneNo x) = show x

instance Show Phone where
  show phone = show cc ++ " "++ show pn ++ " (" ++ show pt ++ ")" 
    where
      cc = countryCode phone
      pn = phoneNo phone
      pt = phoneType phone    

-- 4.3
availableCountryCodes = ["358", "359", "41", "84"]

readPhone :: String -> String -> String -> Phone
readPhone ptStr ccStr pnStr = 
  let pt = read ptStr
      ccStr' = removePrefix ccStr
        where removePrefix ('+':xs) = xs
              removePrefix ('0':'0':xs) = xs
              removePrefix xs = xs
      cc = toCountryCode $ read ccStr'
      pn = toPhoneNo $ read pnStr
  in case ccStr' `elem` availableCountryCodes of
    True  -> toPhone pt cc pn
    False -> error "Unknown country code!"


-- 4.4 / modified to be 5.3
listToMap xs = Map.fromListWith (++) $ map (\(k,v) -> (k,[v])) xs

findEntries :: String -> Map.Map String [Phone] -> [Phone]
findEntries nm pb =
  let entries = Map.lookup nm pb
  in  case entries of
        Just entries -> entries
        Nothing -> []

addEntry :: String -> String -> String -> String -> Map.Map String [Phone] -> Map.Map String [Phone]
addEntry nm ptStr ccStr pnStr oldBook =
  let phone = readPhone ptStr ccStr pnStr
      findPhoneNos = map phoneNo $ findEntries nm oldBook
      numberCheck = (toPhoneNo $ read pnStr) `elem` findPhoneNos
  in case numberCheck of
    True  -> oldBook
    False -> Map.insertWith (++) nm [phone] oldBook


-- Task 6.4

type Phonebook = Map.Map String [Phone]

testPhoneBook = listToMap [
    ("PersonA", (readPhone "Other" "358" "1234567")),
    ("PersonA", (readPhone "WorkMobile" "358" "7234623")),
    ("PersonB", (readPhone "Other" "00358" "1122334455"))]

main :: IO ()
main = do
    -- Start the main loop with a phonebook containing example entries
    mainLoop testPhoneBook

mainLoop :: Phonebook -> IO ()
mainLoop phonebook = do
    putStr "> "
    hFlush stdout   -- Flush the standard output so that the prompt is shown
    line <- getLine
    case words line of
        ("quit":[]) -> return ()
        ("add":name:ptype:ccode:pno:[]) -> do
            -- Note that because the phonebook is made to be lazy, the
            -- addition always succeeds. The possible errors are printed out
            -- when trying to show the created element by using "find".
            let pbook = addEntry name ptype ccode pno phonebook
            putStrLn "OK"
            mainLoop pbook
        ("find":name:[]) -> do
            findFromPhonebook name phonebook
            mainLoop phonebook
        _ -> do
            putStrLn "Invalid input"
            mainLoop phonebook

findFromPhonebook :: String -> Phonebook -> IO ()
findFromPhonebook name phonebook = do
    let entries = findEntries name phonebook
    if null entries then
        putStrLn "No results"
    else
        -- Print results
        putStr $ unlines $ map show entries