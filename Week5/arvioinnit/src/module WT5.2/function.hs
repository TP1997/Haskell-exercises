
type CountryCode' = Integer
type HomeMobile' = String
type WorkMobile' = String

data PhoneType' = PhoneType' { countryCode' :: CountryCode', homeMobile' :: HomeMobile', workMobile' :: WorkMobile'} deriving (Eq, Show, Ord)
