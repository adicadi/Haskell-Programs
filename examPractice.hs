import qualified Control.Applicative as Evaluation
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
