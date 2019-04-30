--Exersize week 7--
{- Exercise: use foldr to redefine sum and product:
sum2::[Int]->Int
product2:: [Int]->Int -}


--sum2::[Int]->Int--
sum2 :: [Int] -> Int
sum2 xs = foldr (+) 0 xs

--product2:: [Int]->Int--
prod :: [Int] -> Int
prod xs = foldr (*) 1 xs