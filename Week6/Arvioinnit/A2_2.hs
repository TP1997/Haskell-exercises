module A2_2 where

--Functional programming I 2019 - Task 6.2

-- Call example:
-- treeInsert ("oili", [readPhone "Other" "+358" "345"]) $ treeInsert ("matti", [readPhone "Other" "+358" "234"])  $ treeInsert ("mikko", [readPhone "Other" "+358" "123"]) EmptyTree


--
-- Copypasta from previous exercises.
--
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other
  deriving (Show, Eq, Read)

data CountryCode = CountryCode Int deriving (Eq)
instance Show CountryCode where
  show (CountryCode a) = "+" ++ show a

data PhoneNo = PhoneNo Int deriving (Eq)
instance Show PhoneNo where
  show (PhoneNo a) = show a

createCountryCode :: Int -> CountryCode
createCountryCode a
  | a < 0 = error "Country code can't be negative!"
  | otherwise = CountryCode a

createPhoneNo :: Int -> PhoneNo
createPhoneNo a
  | a < 0 = error "Phone number can't be negative!"
  | otherwise = PhoneNo a

data Phone = Phone {
  phoneType :: PhoneType,
  countryCode :: CountryCode,
  phoneNo :: PhoneNo
} deriving (Eq)
instance Show Phone where
  show (Phone {phoneType = pt, countryCode = cc, phoneNo = pn})
    = show cc ++ " " ++ show pn ++ " (" ++ show pt ++ ")"

createPhone :: PhoneType -> CountryCode -> PhoneNo -> Phone
createPhone pt cc pn
  = Phone
  { phoneType=pt, countryCode=cc, phoneNo=pn }

allowedCountryCodes = ["1", "44", "46", "358"]

readCountryCode :: String -> CountryCode
readCountryCode (a:b:xs)
  | [a,b] == "00" = readCountryCode xs
  | a == '+' = readCountryCode (b:xs)
  | not $ (a:b:xs) `elem` allowedCountryCodes = error "Country code not found."
  | otherwise = createCountryCode $ read (a:b:xs)

readPhone :: String -> String -> String -> Phone
readPhone pt cc pn =
  Phone {
    phoneType=(read pt:: PhoneType),
    countryCode=(readCountryCode cc),
    phoneNo= (createPhoneNo (read pn :: Int))}

--
-- Actual exercise.
--
data Record = Record {name :: String, phone :: Phone} deriving (Eq, Show)

findByName :: String -> [Record] -> [Record]
findByName s r =
  filter (\(Record {name=n}) -> n == s) r

addNew :: String -> String -> String -> String -> [Record] -> [Record]
addNew name phoneType countryCode phoneNo record
  | findByName name record /= [] = record
  | otherwise =
    (Record{name=name,
    phone=(readPhone phoneType countryCode phoneNo)}):record

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

singleton (key,val) = Node (key,val) EmptyTree EmptyTree

treeInsert (key, val) EmptyTree = singleton (key, val)
treeInsert (keyx, valx) (Node (keyy,valy) left right)
  | keyx==keyy = Node (keyy, valy) left right
  | keyx<keyy = Node (keyy,valy) (treeInsert (keyx, valx) left) right
  | keyx>keyy = Node (keyy,valy) left (treeInsert (keyx,valx) right)

treeElem (keyx, valx) EmptyTree = False
treeElem (keyx, valx) (Node (keyy,valy) left right)
  | keyx==keyy = True
  | keyx<keyy = treeElem (keyx,valx) left
  | keyx>keyy = treeElem (keyx, valx) right