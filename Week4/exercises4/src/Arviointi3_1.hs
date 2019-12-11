module Arviointi3_1 where

readPhone :: String -> String -> String -> Phone
readPhone ptype ccode pnumber = Phone (read ptype) (getCountryCode ccode) (makePhoneNo (read pnumber))

getCountryCode :: String -> CountryCode
getCountryCode s
    |not (s2 `elem` ccodelist) = error "Faulty country code. (not in list)"
    |otherwise = makeCountryCode (read s2)
    where s2 = stripCountryCode s
          ccodelist = ["93","355","213","1684","376","244","1264","6721","1268","54","374","297","247","61","43","994","1242","973","880","1246","375","32","501","229","1441","975","591","599","387","267","55","1284","673","359","226","257","238","855","237","1","1345","236","235","56","86","57","269","243","242","682","506","225","385","53","599","357","420","45","246","253","1767","1809","1829","1849","593","20","503","240","291","372","268","251","500","298","679","358","33","594","689","241","220","995","49","233","350","30","299","1473","590","1671","502","224","245","592","509","504","852","36","354","91","62","98","964","353","972","39","1876","81","962","7","254","686","383","96560901521","996","856","371","961","266","231","218","423","370","352","853","261","265","60","960","223","356","692","596","222","230","262","52","691","373","377","976","382","1664","212","258","95","264","674","977","31","687","64","505","227","234","683","6723","850","389","1670","47","968","92","680","970","507","675","595","51","63","48","351","1787","1939","974","262","40","7","250","599","590","290","1869","1758","590","508","1784","685","378","239","966","221","381","248","232","65","599","1721","421","386","677","252","27","82","211","34","94","249","597","46","41","963","886","992","255","66","670","228","690","676","1868","290","216","90","993","1649","688","256","380","971","44","1","598","998","678","39","58","84","1340","681","967","260","263"]


stripCountryCode :: String -> String
stripCountryCode [] = error "Country code missing."
stripCountryCode (c:s)
    |c == '+' = s
    |c == '0' && null s = error "Faulty country code."
    |c == '0' && head s == '0' = tail s
    |otherwise = c:s


-- This part is just Task 4.2 copypasted:


data PhoneType = WorkLandline | PrivateMobile | WorkMobile | Other deriving (Show, Eq, Read)

data CountryCode = CountryCode Int deriving (Eq)
data PhoneNo = PhoneNo Int deriving (Eq)

instance Show CountryCode where
    show (CountryCode a) = '+': (show a)
instance Show PhoneNo where
    show (PhoneNo a) = show a

makeCountryCode :: Int -> CountryCode
makeCountryCode ccode
    |ccode < 0 = error "Country code must not be negative."
    |otherwise = CountryCode ccode

makePhoneNo :: Int -> PhoneNo
makePhoneNo pno
    |pno < 0 = error "Phone number must not be negative."
    |otherwise = PhoneNo pno

data Phone = Phone { phoneType :: PhoneType
                   , countyCode :: CountryCode
                   , phoneNo :: PhoneNo
                   } deriving (Eq)

instance Show Phone where
    show (Phone a b c) = show b ++ " " ++ show c ++ " (" ++ show a ++ ")"

fun1 :: PhoneType -> CountryCode -> PhoneNo -> Phone
fun1 ptype ccode pno = Phone ptype ccode pno