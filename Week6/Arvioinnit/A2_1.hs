module A2_1 where

-- Copied from 4.4
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving(Show, Read, Eq)


data CountryCode  = MakeCountryCode Integer deriving(Eq,Read)
data PhoneNo      = MakePhoneNo Integer deriving(Eq,Read)
data Phone        = MakePhone {phoneType   :: PhoneType
                              ,countryCode :: CountryCode
                              ,phoneNo     :: PhoneNo    
                              } deriving(Eq, Read)

toCountryCode :: Integer -> CountryCode
toCountryCode x | x < 0 = error "Invalid country code."
                | otherwise = MakeCountryCode x
                  
toPhoneNo :: Integer -> PhoneNo
toPhoneNo x | x < 0 = error "Invalid phone number."
            | otherwise = MakePhoneNo x
              
toPhone :: PhoneType
          -> CountryCode
          -> PhoneNo
          -> Phone
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

availableCountryCodes = ["358", "359", "41", "84"]

readPhone :: String
          -> String 
          -> String
          -> Phone
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

examplePhoneBook =
    addEntry "PersonA" "WorkLandline"  "00358"  "123456789" 
  $ addEntry "PersonA" "PrivateMobile" "358"    "123456789"
  $ addEntry "PersonB" "Other"         "+358"   "123456789"
  $ addEntry "PersonB" "PrivateMobile" "358"    "123456789"
  $ addEntry "PersonA" "WorkLandline"  "00358"  "123456789"
  $ addEntry "PersonA" "WorkMobile"    "358"    "123456789"
  $ addEntry "PersonD" "WorkLandline"  "+358"   "123456789"
  $ addEntry "PersonA" "WorkLandline"  "358"    "123456789"
  $ addEntry "PersonA" "WorkMobile"    "00358"  "123456789"
  $ addEntry "PersonA" "WorkMobile"    "358"    "987654321"
  $ addEntry "PersonB" "WorkLandline"  "358"    "2323"     
  $ addEntry "PersonB" "Other"         "+358"   "144"         
  $ addEntry "PersonC" "WorkLandline"  "358"    "12312123" EmptyTree

-- tests:
-- length $ findEntries "PersonA" examplePhoneBook == 7
-- length $ findEntries "PersonB" examplePhoneBook == 4
-- length $ findEntries "PersonC" examplePhoneBook == 1


------------------ Changes happen here----------------------------------------

-- Enhanced binary tree, with a key k and value a:
data Tree k a = EmptyTree | Node k a (Tree k a) (Tree k a) deriving (Show,Read,Eq)

singleton k val = Node k val EmptyTree EmptyTree

treeInsert k x EmptyTree = singleton k x
treeInsert k x (Node ek ex left right)
  | k == ek = Node ek x left right -- change: overwrite the existing
  | k < ek = Node ek ex (treeInsert k x left) right
  | k > ek = Node ek ex left (treeInsert k x right)

-- lookup an element, returns Maybe a
treeLookup k EmptyTree = Nothing
treeLookup k (Node l y left right)
    | k == l = Just y
    | k<l  = treeLookup k left
    | k>l  = treeLookup k right

type Name = String

-------------------------------------------------------------------------------
-- A type for the tree based phone book
type PhoneBook = Tree Name [Phone]

-- Find entries can now return [Phone], empty list 
-- if nothing is found.
findEntries :: Name -> PhoneBook -> [Phone]
findEntries name book = 
    let fromMaybe = maybe [] id
    in  
        fromMaybe $ treeLookup name book
    

addEntry  :: String
          -> String
          -> String
          -> String
          -> PhoneBook
          -> PhoneBook
addEntry nm ptStr ccStr pnStr oldBook =
  let newEntry = readPhone ptStr ccStr pnStr
      oldEntries = findEntries nm oldBook
  in case oldEntries of
    []  -> treeInsert nm [newEntry] oldBook 
    xs  -> treeInsert nm (newEntry:xs) oldBook





