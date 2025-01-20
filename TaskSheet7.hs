--Task -1(Trees)

--1) Implementing nodes for binary trees.
data BinTree el = EmptyBinTree  
                  | NonEmptyBinTree (BinTree el) el (BinTree el)

nodes :: BinTree el -> [el]
nodes EmptyBinTree = [] --Base Case: empty tree has no nodes. 
nodes (NonEmptyBinTree left val right) = [val] ++ nodes left ++ nodes right --Recursive case: return the value of the current node and the nodes of the left and right subtrees.



--2) Implementing leaves for binary trees.
leaves :: BinTree el -> [el]
leaves EmptyBinTree = [] --Base Case: empty tree has no leaves.
leaves (NonEmptyBinTree EmptyBinTree val EmptyBinTree) = [val] --A single node is a leaf, this means that the left and right subtrees are empty, so return the value of the node.
--(NonEmptyBinTree EmptyBinTree val EmptyBinTree): 
      --The left subtree is EmptyBinTree(no left child). 
      --The right subtree is EmptyBinTree(no right child).
      --val is the value stored in this single node. 
leaves (NonEmptyBinTree left _ right) = leaves left ++ leaves right --Recursive case: return the leaves of the left and right subtrees.
    --If the current node has no children, it is a leaf node. 
    --Return a list containing just the value of this node ([val]).
    --If the current node has children, return the leaves of the left and right subtrees.




-- Implementing height function to calculate the height of a binary tree. 
height :: BinTree el -> Int 
height EmptyBinTree = 0 --Base Case: empty tree has height 0. 
height (NonEmptyBinTree left _ right) = 1 + max (height left) (height right) --Add 1 to the max height of the subtrees. 
--We add 1 to the height of a binary tree at each level because the current node contributes one additional level to the tree height. 




--Implementing Rose Trees. 
data RoseTree el = RoseNode el [RoseTree el]

--Nodes: Collect all nodes. 
roseNodes :: RoseTree el -> [el]
roseNodes (RoseNode val children) = val : concatMap roseNodes children 
--Start with the current node's value (val)
--Recursively collect the values of all child trees using concatMap
    --concatMap roseNodes children applies nodes to each child tree and flattens the resulting list into one. 


--Leaves: Collect all leaves.
roseLeaves :: RoseTree el -> [el]
roseLeaves (RoseNode val []) = [val]    --A node with no children is a leaf. 
roseLeaves (RoseNode _ children) = concatMap roseLeaves children --Recurse over children.


--Height: Calculate tree height. 
roseHeight :: RoseTree el -> Int
roseHeight (RoseNode _ children) = 1 + maximum (0 : map roseHeight children) 
                --The height is 1 + the maximum height of all children. 
                -- if the node has no children(children = []), maximum is applied to the list [0], ensuring the base case for single node trees. 




--Task-2 Tower of Hanoi
hanoi :: Int -> [(Int, Int)]    --Input: The number of disks n. Output: A list of moves represented as pairs (fromTower, toTower).
hanoi 0 = [] --Base Case: if there are no disks (n == 0), no moves are needed.Return an empty list. 
hanoi n = hanoi (n-1) ++ [(1,3)] ++ hanoi (n-1)
    {-
        Solve the problem recursively from n-1 disks:
            -Move n-1 disks from Tower 1 to Tower 2 using Tower 3 as auxilary. 
            -Move the largest disk directly from Tower 1 to Tower 3. 
            -Solve the problem recursively from n-1 disks again:
                -Move the n-1 disks from Tower 2 to Tower 3 using Tower 1 as an auxilary. 
    -}



--Task-3 n-queens
queens :: Int -> [[Int]]
queens n = solve n 
    where 
        solve 0 = [[]]  --Base case: no queens to place, returns an empty solution.
        solve k = [q: qs | qs <- solve (k-1), q <- [1 .. n], safe q qs]
        {-
            Generate all solutions for placing k queens. 
            For each solution qs: 
                try placing a queen (q) in each column from 1 to n. 
            Ensure the placement is valis using the safe function. 
        -}
        safe q qs = and [q /= c && abs (q-c) /= d | (c,d) <- zip qs [1 ..]]
        {-
            Check if placing the queen in column q is safe with respect to the already-placed queens(qs):
                q /= c : Ensure no two queens are in the same column
                abs (q-c) /=d: Ensure no two queens are on the same diagonal:
                    abs (q-c): calculates the difference in columns. 
                    d represents the difference in rows. 
        -}



--Test Cases
main :: IO ()
main = do
     print $ nodes (NonEmptyBinTree (NonEmptyBinTree EmptyBinTree 1 EmptyBinTree) 2 (NonEmptyBinTree EmptyBinTree 3 EmptyBinTree))
     print $ leaves (NonEmptyBinTree (NonEmptyBinTree EmptyBinTree 1 EmptyBinTree) 2 (NonEmptyBinTree EmptyBinTree 3 EmptyBinTree))
     print $ height (NonEmptyBinTree (NonEmptyBinTree EmptyBinTree 1 EmptyBinTree) 2 (NonEmptyBinTree EmptyBinTree 3 EmptyBinTree))
     print $ queens 4