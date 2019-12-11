module Funcs where

--Task 1
task1a :: String
task1a = [val | (val,order) <- zip ['a'..'z'] [1..], odd order]

task1b :: String
task1b = [val | (val,order) <- zip ['a'..'z'] [1..], y<-[3, 5..25], z<-[y, y+2..25], order == y*z]

--Task 2
task2a :: String -> String -> Float
task2a [] [] = 0
task2a xs ys = (xNotInys + yNotInxs)/fromIntegral (length xs + length ys)
         where xNotInys = foldl (\acc x -> if x `elem` ys then acc else acc+1)0 xs
               yNotInxs = foldl (\acc y -> if y `elem` xs then acc else acc+1)0 ys

task2b :: String -> String -> Float
task2b [] [] = 0
task2b xs ys = (xsCount + ysCount)/fromIntegral (length xs + length ys)
         where xsCount = foldl (\acc x -> if x `elem` ['0'..'9'] then acc else acc+1)0 xs
               ysCount = foldl (\acc y -> if y `elem` ['0'..'9'] then acc else acc+1)0 ys


--Task 3
task3a :: (String -> String -> Float) -> Float -> String -> [String] -> [String]
task3a _ _ _ []   = []
task3a f d z (s:ss)
      | f z s <= d = s:task3a f d z ss
      | otherwise  = task3a f d z ss

task3b :: (String -> String -> Float) -> Float -> String -> [String] -> [String]
task3b f d z ss = [s | s<-ss, let dist= f z s in dist <= d]

task3c :: (String -> String -> Float) -> Float -> String -> [String] -> [String]
task3c f d z ss = foldl (\acc s -> if (f z s) <= d then acc++[s] else acc)[] ss

task3d :: (String -> String -> Float) -> Float -> String -> [String] -> [String]
task3d f d z ss = filter (\s -> (f z s) <= d) ss

--Task 4
task4 :: (String -> String -> Float) -> Float -> [String] -> [[String]]
task4 f d ss = [filter (\s -> (f z s) <=d) ss | z<-ss]

