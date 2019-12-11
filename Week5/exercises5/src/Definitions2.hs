module Definitions2 where
--File containing data definutions.

--PhoneType-datatype
data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Eq, Show, Read)

--CountryCode-wrapper
newtype CountryCode = CountryCode Integer deriving(Eq, Read)

--PhoneNo-wrapper
newtype PhoneNo = PhoneNo Integer deriving(Eq, Read)

--Phone-datatype
data Phone = Phone{phoneType :: PhoneType, countryCode :: Maybe CountryCode, phoneNo :: Maybe PhoneNo} deriving (Eq, Read)

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