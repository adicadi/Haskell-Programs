{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use foldr" #-}
{-# HLINT ignore "Use ++" #-}
{-# HLINT ignore "Use sum" #-}
import Prelude hiding (Maybe(..), foldl, foldr, last, (++), reverse, filter, init, concat, splitAt)


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






--2) listprefix to identify the prefix of a list
listprefix :: Int -> [a] -> [a]
listprefix _ [] = [] --Base Case:Prefix of an empty list is an empty list. 
listprefix n (x:xs) 
    | n < 1 = [] --if n is less than 1, return empty list.
    | otherwise = x : listprefix(n-1) xs --Recursive case: Prepend x and recursively call listprefix (n-1) xs to get the rest of the list.   



--3) sublist: extract a sublist of length m starting at position n in the input list. 
sublist :: Int -> Int -> [a] -> [a]
sublist m n xs = take m (drop n xs) -- Drop 'n' elements from the beginning of the list xs and take the first m elements from the remaining list from drop. 


--4) powlist: to generate the power set of a list. 
powlist :: [a] -> [[a]]
powlist [] = [[]] --Base Case: Power set of an empty list is a list containing an empty list. 
powlist (x:xs) = let subsets = powlist xs --Compute the powerset of the smaller list.  
                in subsets ++ map (x:) subsets --Take each subset of xs(stored in subsets) and prepend x to it. This creates new subsets that include x. 
                --Recursive case: Append the subsets of the rest of the list to the subsets of the rest of the list with x prepended to each subset.
{-
    -When the input is not empty, it is split into, x: The first element of the list and xs: The rest of the list. 
    -subsets(all subsets of xs without x)
    -map (x:) subsets: (all subsets of xs with x prepended to each subset)
-}




--Task-4 


--2) Implementing foldr and foldl using recursion.
foldr :: (a->b->b) -> b -> [a] -> b -- A binary function(a->b->b), an initial value of type b and a list of type a, returning a value of type b.
foldr _ acc [] = acc --Base Case: Folding an empty list returns the accumulator.
foldr f acc (x:xs) = f x (foldr f acc xs)  --Recursive case: Apply the function f to the current element x and the result of folding the rest of the list.


--Implementing foldl using recursion.
foldl :: (b->a->b) -> b -> [a] ->b -- A binary function(b->a->b), an initial value of type b and a list of type a, returning a value of type b.
foldl _ acc [] = acc --Base Case: Folding an empty list returns the accumulator. 
foldl f acc (x:xs) = foldl f (f acc x) xs --Recursive case: Apply the function f to the accumulator and the current element x, then fold the rest of the list.


--Implementing lastElement using foldl
data Maybe a = Nothing | Just a

lastElement :: [a] -> Maybe a
lastElement = foldl (\_ x -> Just x) Nothing --Fold the list using foldl, with the accumulator being Nothing and the function that returns Just x for the current element x.




--Implementing the none function using foldr
none :: (a -> Bool) -> [a] ->Bool
none p = foldr (\x acc -> not (p x) && acc)True --Fold the list using foldr, with the accumulator being True and the function that returns True if the predicate p is False for the current element x and the accumulator is True.



--Implementing exist function using foldr
exist :: (a -> Bool) -> [a] -> Bool
exist p = foldr (\x acc -> p x || acc) False --Fold the list using foldr, with the accumulator being False and the function that returns True if the predicate p is True for the current element x and the accumulator is False.




--Implementing exactlyOne using the foldl function
exactlyOne :: (a ->Bool) -> [a] -> Bool
exactlyOne p = (==1).foldl (\count x -> if p x then count +1 else count) 0 --Fold the list using foldl, with the accumulator being 0 and the function that increments the count if the predicate p is True for the current element x, then checks if the count is equal to 1.




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
  print $ listprefix 2 [1,2,3,4]
  print $ sublist 2 4 [1,2,3,4,5,6]
  print $ powlist [1,2,3,4]
  print $ foldr (+) 0 [1,2,3,4]
  print $ foldl (+) 0 [1,2,3,4]
  print $ none even [1,3,5,2]
  print $ exist even [1,3,5,2]
  print $ exactlyOne even [1,3,5,2]