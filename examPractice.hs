-- file TriangleArea
{-
area :: (Double, Double, Double) -> Double
area (a, b, c) = sqrt(s*(s-a)*(s-b)*(s-c))
    where s = (a+b+c)/2

main :: IO ()
main = do
    putStrLn "Enter the sides of the triangle"
    a <- getLine
    b <- getLine
    c <- getLine
    let sides = (read a, read b, read c)
    putStrLn $ "The area of the triangle is: " ++ show(area sides)
    --let trianglesides = (3,4,5)
    --putStrLn $ "The area of the triangle is: " ++ show(area trianglesides)
    -}



--Higher Order Functions
{-
addLists :: [Int] -> [Int] -> [Int]
addLists = zipWith (+)

main :: IO ()
main = do
    putStrLn "Enter the first list"
    a <- getLine
    putStrLn "Enter the second list"
    b <- getLine
    let list1 = read a
    let list2 = read b
    putStrLn $ "The sum of the lists is: " ++ show(addLists list1 list2)

    --For predefined lists
    --let list1 = [1,2,3]
    --let list2 = [4,5,6]
    --putStrLn $ "The sum of the lists is: " ++ show(addLists list1 list2)

    --For declaring list directly in the function
--main = print (addLists [1,2,3] [4,5,6])
-}


{-
--Write a function to sum a list using foldr. Fold Functions

sumList :: [Int] -> Int
sumList = foldr (+) 0 --Foldr is a higher order function that recursively processes a list from right to left. (+) is the binary operator used to combine elements, 0 is the initial value or accumulator used as the starting point of the fold. 
-- foldr processes the list from right to left. 
-- means it starts with the last element and builds up the result recursively.
-- (0) acts as the base value for the folding operation
-- foldr (+) 0 [1,2,3,4,5] = 1 + (2 + (3 + (4 + (5 + 0)))) = 15
main :: IO ()
main = do 
    putStrLn "Enter the list of numbers"
    a <- getLine
    let list = read a
    putStrLn $ "The sum of the list is:" ++ show(sumList list)

-}

{-
--Write a function to generate an infinite list of natural numbers. Lazy Evaluation.

nats :: [Int]
nats = [1..]
-- nats is an infinite list of natural numbers starting from 1.
-- the syntax [1..] uses Haskell's rnage syntax to create an infinite sequence.

main :: IO ()
main = do 
    putStrLn "Enter the number of natural numbers to display"
    --putStrLn prints the message to the console.
    a <- getLine
    --getLine reads a line of input from the user as a string, which is stored in the variable a 
    let n = read a
    putStrLn $ "The first " ++ show n ++ "natural numbers are:" ++ show(take n nats)
    -- take n nats: extracts the first n elements from the infite list nats. take is a pure function that extracts elements from a list without modifying the original list. 
-}





--Generate an inifinte list of Hamming numbers. Hamming Numbers

{-
    They are numbers whose prime factors are limited to 2,3 and 5.

    Each number in the sequence 1,2,3,4,5,6,7,8,9.... can be formed by multiplying a Hamming number by 2, 3 or 5.
    if x is a Hamming number, then 2*x, 3*x and 5*x are also Hamming numbers.

    the sequence of Hamming numbers starts with 1, and each subsequent Hamming number is the smallest number that can be formed by multiplying a Hamming number by 2, 3 or 5.
-}

--We need a function to merge three sorted lists while removing duplicates.
{-
merge :: [Int] -> [Int] -> [Int] -> [Int] --merge takes three sorted lists and combines them into one sorted list.
merge (a:as) (b:bs) (c:cs) = 
    let m = minimum [a,b,c] -- minimum[a,b,c] picks the smallest element among the three heads.
    in m : merge (if m == a then as else a:as) -- the smallest element m is added to the result list, the respective list pointer is moved forward, i.e. if m == a, move to as. 
                    (if m == b then bs else b:bs)
                    (if m == c then cs else c:cs)

-- Define the sequence of Hamming numbers using lazy evaluation.
hamming :: [Int]
hamming = 1 : merge (map (2*) hamming) --Start with the base Hamming number 1, and use map to multiply the Hamming numbers by 2, 3 and 5.
                    (map (3*) hamming) -- Using map to generate mulitples, Using merge to combine infinite sorted lists.
                    (map (5*) hamming)

main :: IO ()
main = do
    putStrLn "Enter the number of Hamming numbers to display"
    a <- getLine
    let n = read a
    putStrLn $ "The first " ++ show n ++ " Hamming numbers are:" ++ show(take n hamming)
--main = print (take 10 hamming)

{-
The sequence starts with 1. 1 generates 2x1 = 2, 3x1 = 3, 5x1 = 5.
The merge function ensures that the sequence remains sorted and eliminates duplicates.
-}

-}


{-
--The Sieve of Eratosthenes Algorithm. 


The Sieve of Eratosthenes is an ancient algorithm for finding all prime numbers up to a given limit.
It works as:
    1. Start with a list of integers beginning at 2.
    2. Take the first number(which is always prime) and remove all of its multiples from the list. 
    3. Repeat the process with the next number in the list, which will be the next prime. 
    4. Continue until you've processed all numbers in the list. 

-- For an infinite sequence, we can apply this principle recursively.
-}

{-
primes :: [Int]
primes = sieve [2..] -- An infinite list of prime numbers starting from 2, generated using sieve function.
    where
        sieve (p:xs) = p : sieve [x | x <- xs, x `mod` p /= 0] 
        -- Recursion: Pattern Matching: (p:xs) splits the list into: 
        -- p: the first element of the list, which is always prime.
        -- xs: The rest of the list(candidates for primes). 

    {- x | x <- xs, is [expression | pattern <- list, condition].
        -- expression: Specifies how to transform each element from the input list. 
                       The result of this transformation is added to the new list. 
        -- pattern <- list: Iterates over each element in the input list(list) and binds it to the variable defined in the "pattern". 
        -- condition(optional): Filters elements that satify a certain condition. Only elements that satisfy the condition are included in the new list. 

        x (before the |): The element to include in the new list. In this case, x is directly added without any transformation.
        x <- xs: Reads as: "Take each element x from the list xs".
        This is a generator that iterates over the list xs.  

        [x | x <- xs, x `mod` p /= 0] is a list comprehension that filters out all multiples of p from the list xs.
        x <- xs iterates over each element x in the list xs. 
        x mod p /= 0 filters out any x that is a mulitple of p(i.e., where x mod p == 0). 
    -}
    
main :: IO ()
main = print (take 10 primes)


-}


{-
--Write a function to compute the square root of a number using the Newton-Raphson method.
--Newton-Raphson Approximation.
{-The Newton-Raphson method is an iterative numerical method for finding successively 
    better approximations to the roots of a real- valued function
    -}

sqrtApprox :: Double -> Double
sqrtApprox a = head [x | (x,y) <- zip approximations (tail approximations), abs (x-y) < 1e-8] -- Purpose: Stops the iteration once the difference between successive approximations is less than a small tolerance value(1e-8).
    -- The list comprehension keeps only pairs where: abs(x-y) < 1e-8, this ensures that the iteration stops when the approximation has converged. 
    -- head: Extracts the first approximation that meets the convergence condition.
    where 
        approximations = iterate (\x -> (x + a/x)/2) (a / 2) 
        {-  
            -- Generates an infinite list of approximations for the square root of a using the Newton-Raphson method.
            1. iterate: Build-in function that takes a function and initial value and returns an infinite list of results by applying the function repeatedly. 
        -}

        -- Edge Cases: if a < 0, an error message is returned because negative numbers don't have real square roots.
        -- if a == 0, the square root is 0.    

main :: IO ()
main =  do --print (sqrtApprox 20) -- The square root of 2 is approximately 1.4142135623730951
    putStrLn "Enter the number to compute its square root:"
    a <- getLine
    let n = read a :: Double
    if n < 0 
        then putStrLn "Please enter a positive number"
    else putStrLn $ "The square root of " ++ show n ++ " is approximately: " ++ show(sqrtApprox n)

-}





{-

--Scanner: Tokenizer
--Implement a scanner for simple arithmetic expressions.
-- A scanner reads a stream of characters and break it into tokens. Each token represents a meaningful unit, such as: Numbers, Identifiers, Symbols, Keywords, Layout or whitespace, Illegal characters. 

data Token = Number String | Open | Close | Comma | Illegal String deriving Show

scanner :: String -> [Token]
{-
    The scanner: Takes an input string and returns a list of tokens
    String: Represents the input text(Sequence of characters)
    Token: A list of tokens generated by processing the input.
-}
scanner [] = [] -- Base Case: Empty string returns an empty list.
{-
    Purpose: Handles the base case when the input string is empty.
    Behaviour: If the input is [](Empty), returns an empty list of tokens([])
    This ensures recursion stops when the string is fully processed.
-}
scanner (x:xs) -- (x:xs) Splits the input string into: x: The first character(Head), xs: The rest of the characters(tail). 
    | x == '(' = Open : scanner xs --if x is '(', add the Open token to the result and continue processing the rest of the string Xs. 
    | x == ')' = Close : scanner xs
    | x == ',' = Comma : scanner xs
    | isDigit x = 
        let (num, rest) = span isDigit (x:xs) -- if x is a digit(isDigit x), process it as a part of a number.
            -- span isDigit: Splits the input into two parts: The longest prefix of a characters that satify isDigit. The rest of the string.
        in Number num : scanner rest --Match a number and add it to the token list.,, The scanner continues processing rest. 
    | isSpace x = scanner xs -- Skip whitespace.,, If x is a space(isSpace x), skip it. 
    | otherwise = 
        let (illegal, rest) = span (\c -> not (isSpace c || isDigit c || c `elem` "(),")) (x:xs) --Handles characters which do not match any valid category. 
        in Illegal illegal : scanner rest --Match illegal characters and add them to the token list.
  where 
    isDigit c = c >= '0' && c <= '9' --Check if a character is a digit between '0' and '9'. 
    isSpace c = c == ' ' --Check if a character is a space.

main = print (scanner "(123, 456)")
-- Base Case: Stops recursion when the input is empty. 
-- Token Matching: Matches characters to specific token types.
-- Whitespace: Skipped entirely. 
-- Illegal Characters: Grouped into Illegal tokens for invalid sequences. 


-}