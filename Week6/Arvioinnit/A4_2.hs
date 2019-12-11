module A4_2 where

import System.IO
import System.Exit(exitSuccess)
import Control.Monad(when)
import Data.Maybe(fromJust)

prompt = "phonebook> "

findPerson :: [PhoneBook] -> String -> String
findPerson (MakePhoneBook pt cc pn name:xs) compareName
  | name == (MakeName compareName) = show (MakePhoneBook pt cc pn name)
  | null xs = "Person not found"
  | otherwise = findPerson xs compareName

handleFind :: [PhoneBook] -> String -> IO ()
handleFind phonebooks compareName =
  if null phonebooks
  then error "Phonebook is empty"
    else do
      let output = findPerson phonebooks compareName 
      putStrLn output

main :: IO ()
main = runProgram []

runProgram :: [PhoneBook] -> IO ()
runProgram phonebooks = do
  putStrLn $ prompt ++ "Use add or find commands"
  userInput <- getLine
  let newInput = words userInput

  when (null newInput) $ runProgram phonebooks 
  when ((unwords newInput) == "quit") $ exitSuccess
  when ((head newInput) == "add") $ do
    let addArgs = tail newInput
    when (length addArgs /= 4) $ putStrLn "not enough arguments" 
    let [name, pt, cc, pn] = addArgs
        newData = readPhoneBook pt cc pn name
    let updatedPhoneBook = newData:phonebooks 
    putStrLn (show newData)
    putStrLn "Added"
    runProgram updatedPhoneBook
  when ((head newInput) == "find") $ do 
    let findArgs = unwords (tail newInput)
    handleFind phonebooks findArgs


  runProgram phonebooks

readMaybe :: (Read a) => String -> Maybe a  
readMaybe st = case reads st of [(x,"")] -> Just x  
                                _ -> Nothing

-- code below is mainly 6.1 with minor changes such as PhoneBook instead of Phone
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving(Show, Read, Eq)

newtype CountryCode  = MakeCountryCode Integer deriving(Eq,Read)
newtype PhoneNo      = MakePhoneNo Integer deriving(Eq,Read)
newtype Name         = MakeName String deriving(Eq, Read)
data PhoneBook       = MakePhoneBook { phoneType   :: Maybe PhoneType
                                     , countryCode :: Maybe CountryCode
                                     , phoneNo     :: PhoneNo
                                     , name        :: Name
                                     } deriving(Eq, Read)

availableCountryCodes = ["358", "359", "41", "84"]
toCountryCode :: Maybe Integer -> Maybe CountryCode
toCountryCode x =
  case x of
    Nothing -> error "Invalid country code."
    Just y
      | not $ (show y) `elem` availableCountryCodes -> error "Country code not available."
      | otherwise -> Just $ MakeCountryCode y

toPhoneNo :: Integer -> PhoneNo
toPhoneNo x 
  | x < 0 = error "Invalid phone number."
  | otherwise = MakePhoneNo x
              
toPhoneBook ::   Maybe PhoneType
              -> Maybe CountryCode
              -> PhoneNo
              -> Name
              -> PhoneBook
toPhoneBook pt cc pn name = MakePhoneBook pt cc pn name

toName :: String -> Name
toName name = MakeName name

instance Show CountryCode where
  show (MakeCountryCode x) = '+' : show x

instance Show PhoneNo where
  show (MakePhoneNo x) = show x

instance Show PhoneBook where
  --Pattern matching the new value constructor.
  show (MakePhoneBook Nothing Nothing pn name)     = show pn
  show (MakePhoneBook Nothing (Just cc) pn name)   = show cc ++ " "  ++ show pn
  show (MakePhoneBook (Just pt) Nothing pn name)   = show pn ++ " (" ++ show pt ++ ")"
  show (MakePhoneBook (Just pt) (Just cc) pn name) = show cc ++ " "  ++ show pn ++ " (" ++ show pt ++ ")"

readPhoneBook :: String
              -> String
              -> String
              -> String
              -> PhoneBook
readPhoneBook ptStr ccStr pnStr name = 
  let pt = readMaybe ptStr :: Maybe PhoneType
      ccStr' = removePrefix ccStr
        where removePrefix ('+':xs) = xs
              removePrefix ('0':'0':xs) = xs
              removePrefix xs = xs
      cc = toCountryCode $ (readMaybe ccStr' :: Maybe Integer)
      pn = toPhoneNo $ read pnStr
      nm = toName name
  in case (pt, cc, pn, nm) of
    ( _, _, _, _) -> toPhoneBook pt cc pn nm
