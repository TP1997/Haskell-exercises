module Funcs2 where

------------------------------------Data definitions--------------------------------------------------
--Phone stuff:
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Eq, Show, Read)

data CountryCode = CountryCode Integer deriving(Eq, Read)
data PhoneNo = PhoneNo Integer deriving(Eq, Read)
data Phone = Phone{ phoneType   :: PhoneType
                   ,countryCode :: CountryCode
                   ,phoneNo     :: PhoneNo} deriving (Eq, Read)

--Binary tree:
data Tree = EmptyTree | Node String [Phone] Tree Tree deriving (Show,Read,Eq)

ccList = ["358", "359", "41", "84"]
------------------------------------Instances---------------------------------------------------------
instance Show CountryCode where
    show (CountryCode cc) = "+" ++ show cc

instance Show PhoneNo where
    show (PhoneNo pn) = show pn

instance Show Phone where
    show (Phone pt cc pn) = show cc++" "++show pn++" ("++show pt++")"         
------------------------------------Other functions---------------------------------------------------
readPhone :: String -> String -> String -> Phone
readPhone pts ccs pns = let pt   = read pts :: PhoneType
                            ccs' = removePrefix ccs
                                where removePrefix ('+':xs) = xs
                                      removePrefix ('0':'0':xs) = xs
                                      removePrefix xs = xs
                            cc = toCountryCode $ read ccs'
                            pn = toPhoneNo $ read pns
                            in case ccs' `elem` ccList of 
                                True -> Phone pt cc pn
                                False -> error "Unknown country code."

toPhoneNo :: Integer -> PhoneNo
toPhoneNo pni
    | pni < 0   = error "Invalid phone number."
    | otherwise = PhoneNo pni

toCountryCode :: Integer -> CountryCode
toCountryCode cci
    | cci < 0   = error "Invalid country code."
    | otherwise = CountryCode cci

------------------------------------Binary tree functions---------------------------------------------
singleton :: String -> Phone -> Tree
singleton s p = Node s [p] EmptyTree EmptyTree

--Function uses string comparison to deduce order of the nodes.
treeInsert :: String -> Phone -> Tree -> Tree
treeInsert s p EmptyTree = singleton s p
treeInsert s p (Node k v left right)
    | s == k = Node k (addList v p) left right
    | s < k  = Node k v (treeInsert s p left) right
    | s > k  = Node k v left (treeInsert s p right)

addList :: [Phone] -> Phone -> [Phone]
addList pList phone
    | (phoneNo phone) `elem` (map phoneNo $ pList) = pList
    | otherwise = pList++[phone]


------------------------------------User functions----------------------------------------------------
addEntry :: String -> String -> String -> String -> Tree -> Tree
addEntry nm pts ccs pns tree = treeInsert nm phone tree
                              where phone = readPhone pts ccs pns


{- Example usage:
let tree1 = addEntry "test1" "Other" "+358" "1111" EmptyTree
addEntry "test2" "WorkMobile" "+358" "2222" tree1
jne...
-}                      