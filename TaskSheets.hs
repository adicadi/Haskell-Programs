{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use foldr" #-}
{-# HLINT ignore "Use ++" #-}
import Prelude hiding (last, (++), reverse, filter, init, concat, splitAt)


--Task-3: Functions in Haskell

--a) (++) List Concatenation
(++) :: [a] -> [a] -> [a]
[] ++ ys = ys --Base case: Concatenating an empty list to ys gives ys
   -- If we take the 1st list and it is empty, we'll return the 2nd List.
(x: xs) ++ ys = x : (xs ++ ys) --Recursive case: Prepend x to the result of (xs ++ ys)


--b) Reverse a List
reverse :: [a] -> [a]
reverse [] = [] --Base Case: Reversing an empty list returns empty list. 
reverse (x:xs) = reverse xs ++ [x] -- Recursive case: reverse the rest of the list, the apend x.


--c) last 
last :: [a] -> a
last [x] = x --Base Case: the last element of a single-element list returns  the element itself. 
last (_: xs) = last xs --Recursive case: ignore the first element and call 'last' on the rest, which means continue traversing the list by calling the last on the tail (xs), until a single element list is reached. 


--d) filter
filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = [] --Base Case: Filtering an empty list, will return an empty list. 
filter p (x:xs)
    | p x = x : filter p xs --If 'x' satifies the predicate, iclude it in the result. 
    | otherwise = filter p xs --Otherwise, ignore it and continue filtering the rest of the list.
 --Takes a predicate function (a-> Bool) and a list, returning a new list of only those elements for which the predicate is True. 


--e) init
init :: [a] -> [a]
init [x] = [] --Base Case: the initial part of a single-element list is an empty list. 
init (x:xs) = x : init xs --Recursive case: prepend x in the result of 'init xs'. 
 --Returns all elements of a list except the last one. 
 --if the list is empty, it throws an error, otherwise if the list has just one element [x], the result is [](there's nothing left after removing x).
 --Otherwise, prepend x to the init of the tail. 



--f) concat
concat :: [[a]] -> [a]
concat [] = [] --Base Case: Concatenating an empty list of list gives us an empty list. 
concat (xs: xss) = xs ++ concat xss --Recursive case: Concatenate the first list with the result of concatenating the rest of the list. 
 --Concatenates a list of lists into a single list. 
 --If the list is empty, it returns an empty list. 
 --Otherwise, concatenate the first list with the result of concatenating the rest of the list.


--g) splitAt
splitAt:: Int -> [a] -> ([a], [a])
splitAt 0 xs = ([], xs) --BaseCase: Splitting at index 0 gives an empty first part. 
splitAt _ [] = ([],[]) --BaseCase: Splitting an empty list gives us two empty lists. 
splitAt n (x:xs) = 
   let (first, second) = splitAt (n-1) xs in (x: first, second) --Recursive case: prepend x to the first part of the splitAt (n-1) of the rest of the list.
--For each element, decrement n and recursively split the rest until n becomes 0. 



--Test Cases
main :: IO ()
main = do
  print $ [1,2,3] ++ [4,5,6]
  print $ reverse [1,2,3]
  print $ last [1,2,3]
  print $ filter odd [1,2,3,4,5,6]
  print $ init [1,2,3]
  print $ concat [[1,2],[3,4]]
  print $ splitAt 2 [1,2,3,4]