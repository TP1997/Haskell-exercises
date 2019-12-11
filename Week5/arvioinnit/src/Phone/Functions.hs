module Phone.Functions
( toCountryCode
, toPhoneNo
, toPhone
, readPhone
)where 

import qualified Phone.Definitions as Definitions
toCountryCode :: Integer -> Definitions.CountryCode
toCountryCode x | x < 0 = error "Invalid country code."
                | otherwise = MakeCountryCode x
                  
toPhoneNo :: Integer -> Definitions.PhoneNo
toPhoneNo x | x < 0 = error "Invalid phone number."
            | otherwise = MakePhoneNo x
              
{- This is actually the same as the data/value constructor for Phone. You can try :t MakePhone in ghci to see the type of the data/value constructor.
-}
toPhone :: Maybe Definitions.PhoneType
          -> Maybe Definitions.CountryCode
          -> Definitions.PhoneNo
          -> Definitions.Phone
toPhone Nothing Nothing pn = MakePhone Nothing Nothing pn
toPhone Nothing (Just cc) pn = MakePhone Nothing (Just cc) pn
toPhone (Just pt) Nothing pn = MakePhone (Just pt) Nothing pn
toPhone (Just pt) (Just cc) pn = MakePhone (Just pt) (Just cc) pn

-- Type constructor |
--                  |
--                  v

availableCountryCodes = ["358", "359", "41", "84"]

readPhone :: String
          -> String 
          -> String
          -> Definitions.Phone
readPhone [] [] pnStr = toPhone Nothing Nothing (toPhoneNo $ read pnStr)
readPhone [] ccStr pnStr =
  let ccStr' = removePrefix ccStr --Note that the implementation of this function is right below inside the where clause.
        where removePrefix ('+':xs) = xs
              removePrefix ('0':'0':xs) = xs
              removePrefix xs = xs
      cc = toCountryCode $ read ccStr'
      pn = toPhoneNo $ read pnStr
  in case ccStr' `elem` availableCountryCodes of
    True  -> toPhone Nothing (Just cc) pn
    False -> error "Unknown country code!"
readPhone ptStr [] pnStr = toPhone (Just (read ptStr)) Nothing (toPhoneNo $ read pnStr)
readPhone ptStr ccStr pnStr = 
  let pt = read ptStr -- The derived Read instance makes the read function read a value out of string which is formatted the same as using show with derived instance for Show. (There could also be parentheses around it e.g. "(((WorkLandline)))" would read the same value as "WorkLandline")
      ccStr' = removePrefix ccStr --Note that the implementation of this function is right below inside the where clause.
        where removePrefix ('+':xs) = xs
              removePrefix ('0':'0':xs) = xs
              removePrefix xs = xs
      cc = toCountryCode $ read ccStr'
      pn = toPhoneNo $ read pnStr
  in case ccStr' `elem` availableCountryCodes of
    True  -> toPhone (Just pt) (Just cc) pn
    False -> error "Unknown country code!"

----