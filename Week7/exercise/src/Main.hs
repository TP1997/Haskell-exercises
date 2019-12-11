module Main where

-----------------------------------Date stuff----------------------------------------------------
newtype Year = MakeYear Integer deriving (Eq, Ord)
data Month = MakeMonth Integer deriving (Eq, Ord)
data Day = MakeDay Integer deriving (Eq, Ord)
data Date = Date { year :: Year, month :: Month, day :: Day } deriving (Eq, Ord)

instance Show Year where
    show (MakeYear y) | y < 10 = "000" ++ show y
                      | y >=10 && y < 100 = "00" ++ show y
                      | y >=100 && y < 1000 = "0" ++ show y
                      |otherwise = show y 
instance Show Month where
    show (MakeMonth m) | m < 10 = "0" ++ show m
                       | otherwise = show m
instance Show Day where
    show (MakeDay d) | d < 10 = "0" ++ show d
                     | otherwise = show d
instance Show Date where
    show (Date y m d) = (show y) ++ "-" ++ (show m) ++ "-" ++ (show d)


leapYear (MakeYear y)
  | mod y 400 == 0 = True
  | mod y 100 == 0 = False
  | mod y 4 == 0 = True
  | otherwise = False

toYear :: Integer -> Year
toYear x
 | x == 0 = error "No year 0"
 | otherwise = MakeYear x

toMonth :: Integer -> Month
toMonth x
  | x < 1     = error "Minimum month number is 1" 
  | x > 12     = error "Maximum month number is 12" 
  | otherwise = MakeMonth x

toDay :: Integer -> Day
toDay x
  | x < 1     = error "Minimum day number is 1" 
  | x > 31     = error "Maximum day number is 31" 
  | otherwise = MakeDay x  

makeMaybeDate :: Integer -> Integer -> Integer -> Maybe Date
makeMaybeDate y m d
 | y <= 0 = Nothing
 | elem m [1,3,5,7,8,10,12] &&
   elem d [1..31] = makeJustDate y m d
 | elem m [4,6,9,11] &&
   (elem d [1..30]) = makeJustDate y m d
 | m==2 && elem d [1..28] = makeJustDate y m d
 | leapYear (toYear y) && m==2 && d==29 = makeJustDate y m d
 | otherwise = Nothing
 where makeJustDate y m d = Just Date {year = MakeYear y, month = MakeMonth m, day = MakeDay d}


data EventInfo = EventInfo { name :: String
                           , place :: String
                           , date :: Date
                           } deriving(Eq)      

instance Show EventInfo where
  show (EventInfo name place date) = "Event "++name++" happens at "++place++" on "++(show date)

class ShowDate a where
  showDate :: a -> String

instance ShowDate EventInfo where
  showDate (EventInfo name _ date) = "Event "++name++" happens on "++(show date)

class ShowPlace a where
  showPlace :: a -> String

instance ShowPlace EventInfo where
  showPlace (EventInfo name place _) = "Event "++name++" happens at "++place
----------------------------------------Main program----------------------------------------------------
main = loop $ return []
 
loop :: IO [EventInfo] -> IO ()
loop ioEvents =
 do
 input <- getLine
 if input == "Quit"
   then putStrLn "bye"
   else doCommand input ioEvents

----------------------------------------Template for doCommand------------------------------------------
invalidCommandMsg = "I do not understand that. I understand the following:\n\
                    \*Event <name> happens at <place> on <date>\n\
                    \*Tell me about <eventname>\n\
                    \*What happens on <date>\n\
                    \*What happens at <place>\n\
                    \*Quit"

x = "This is some text which we e\nscape \n\
      \   and unescape to keep writing"                    

doCommand :: String -> IO [EventInfo] -> IO ()
doCommand input ioEvents = do
  events <- ioEvents --Now you can use events as [EventInfo]
  let args = split (=='\'') input
  case args of 
      ("Event ":sEventname:" happens at ":sPlace:" on ":sDate:[]) -> do 
                                                                     let dateArgs = split (=='-') sDate
                                                                     newEvents <- createEvent sEventname sPlace dateArgs events
                                                                     loop $ return (newEvents)
      ("Tell me about ":sEventname:[]) -> do 
                                          case findEventByName sEventname events of
                                            (Just event) -> putStrLn $ show event
                                            Nothing -> putStrLn "I do not know of such event"
                                          loop $ return (events)

      ("What happens on ":sDate:[]) -> do 
                                       let foudEvents = findEventsBysDate sDate events
                                       case foudEvents of
                                         [] -> putStrLn "Nothing that I know of"
                                         otherwise -> printByDate foudEvents
                                       loop $ return (events)

      ("What happens at ":sPlace:[]) -> do
                                        let foudEvents = findEventsByPlace sPlace events
                                        case foudEvents of
                                         [] -> putStrLn "Nothing that I know of"
                                         otherwise -> printByPlace foudEvents
                                        loop $ return (events)
      otherwise -> do invalidCommand
                      loop $ return (events)


invalidCommand :: IO ()
invalidCommand = do putStrLn invalidCommandMsg

split :: (Char -> Bool) -> String -> [String]
split f s = case dropWhile f s of
                "" -> []
                s' -> w:split f s''
                        where (w, s'') = break f s'

readMaybe :: (Read a) => String -> Maybe a
readMaybe str = case reads str of
                [(val, "")] -> Just val
                _ -> Nothing

returnWithMsg :: String -> a -> IO a
returnWithMsg s a = do putStrLn s
                       return (a)

createEvent :: String -> String -> [String] -> [EventInfo] -> IO [EventInfo]
createEvent evname place (sYear:sMonth:sDay:_) events = do
      let year=readMaybe sYear :: Maybe Integer
          month=readMaybe sMonth :: Maybe Integer
          day=readMaybe sDay :: Maybe Integer

          idx = elemIndex evname $ map name events
      case (year,month,day,idx) of 
        (Just y, Just m, Just d, Nothing) -> case makeMaybeDate y m d of
                                              Just date -> returnWithMsg "ok" $ addEvent (EventInfo evname place date) events
                                              Nothing -> returnWithMsg "Bad date" events
        (Just y, Just m, Just d, Just oldEventIdx) -> case makeMaybeDate y m d of
                                                      Just date -> returnWithMsg "ok" (updateEvent (EventInfo evname place date) oldEventIdx events)
                                                      Nothing -> returnWithMsg "Bad date" events
        otherwise -> returnWithMsg "Bad date" events
createEvent _ _ _ events = returnWithMsg "Bad date" events

elemIndex :: (Eq a) => a -> [a] -> Maybe Int
elemIndex _ [] = Nothing
elemIndex elem (e:elems)
  | elem == e = Just 0
  | otherwise = fmap (+1) $ elemIndex elem elems

updateEvent :: EventInfo -> Int -> [EventInfo] -> [EventInfo]
updateEvent newEvent oldEventIdx events = addEvent newEvent $ removeEvent oldEventIdx events

removeEvent :: Int -> [a] -> [a]
removeEvent _ [] = []
removeEvent i (x:xs)
  | i == 0 = xs
  | otherwise = x:removeEvent (i-1) xs

addEvent :: EventInfo -> [EventInfo] -> [EventInfo]
addEvent newEvent [] = [newEvent]
addEvent newEvent (e:events)
  | (name newEvent) < (name e) = newEvent:e:events
  | otherwise = e:addEvent newEvent events

findEventByName :: String -> [EventInfo] -> Maybe EventInfo
findEventByName _ [] = Nothing
findEventByName eventname (e:events)
  | eventname == name e = Just e
  | otherwise = findEventByName eventname events

findEventByName' :: String -> [EventInfo] -> [EventInfo]
findEventByName' eventname events = filter (\e -> eventname == (name e)) events

findEventsByDate :: Date -> [EventInfo] -> [EventInfo]
findEventsByDate eventdate events = filter (\e -> eventdate == (date e)) events

findEventsBysDate :: String -> [EventInfo] -> [EventInfo]
findEventsBysDate eventdate events = filter (\e -> eventdate == (show $ date e)) events

findEventsByPlace :: String -> [EventInfo] -> [EventInfo]
findEventsByPlace eventplace events = filter (\e -> eventplace == (place e)) events

printByDate :: [EventInfo] -> IO ()
printByDate [] = do return ()
printByDate (e:events) = do putStrLn $ showDate e
                            printByDate events

printByPlace :: [EventInfo] -> IO ()
printByPlace [] = do return ()
printByPlace (e:events) = do putStrLn $ showPlace e
                             printByPlace events

printBy :: (EventInfo -> String) -> [EventInfo] -> IO ()
printBy f [] = do return ()
printBy f (e:events) = do putStrLn $ f e
                          printBy f events

