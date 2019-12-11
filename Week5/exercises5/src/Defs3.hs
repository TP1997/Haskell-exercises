module Defs3 where

import qualified  Data.Map as Map

--File containing data definitions.

--PhoneType-datatype
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Eq, Show, Read)

--CountryCode-wrapper
data CountryCode = CountryCode Integer deriving(Eq, Read)

--PhoneNo-wrapper
data PhoneNo = PhoneNo Integer deriving(Eq, Read)

--Phone-datatype
data Phone = Phone{phoneType :: PhoneType, countryCode :: CountryCode, phoneNo :: PhoneNo} deriving (Eq, Read)

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

--Map of predefined book entries.
mapEntries = Map.fromList [( "entry1", Phone WorkLandline  (CountryCode 111) (PhoneNo 121212) ),
                           ( "entry2", Phone PrivateMobile (CountryCode 222) (PhoneNo 232323) ),
                           ( "entry3", Phone WorkMobile    (CountryCode 333) (PhoneNo 343434) ),
                           ( "entry4", Phone Other         (CountryCode 444) (PhoneNo 454545) ),
                           ( "entry5", Phone Other         (CountryCode 555) (PhoneNo 565656) ),
                           ( "entry6", Phone WorkLandline  (CountryCode 666) (PhoneNo 676767) )
                          ] 
                          