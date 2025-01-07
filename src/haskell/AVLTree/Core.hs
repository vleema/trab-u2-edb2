module AVLTree.Core where

import Debug.Trace
import Direction
import Prelude

data AVLTree a
    = Node
        { key :: a
        , left :: AVLTree a
        , right :: AVLTree a
        }
    | Nil

height :: (Ord a) => AVLTree a -> Int
height Nil = 0
height (Node _ l r) = 1 + max (height l) (height r)

search :: (Ord a) => AVLTree a -> a -> Maybe [Direction]
search Nil _ = Nothing
search (Node k l r) v
    | v == k = Just []
    | v <= k = fmap (L :) (search l v) -- fmap :: (Ldir -> Ldir) -> (MLdir -> MLdir)
    | otherwise = fmap (R :) (search r v)

balanced :: (Ord a) => AVLTree a -> Bool
balanced Nil = True
balanced (Node _ l r)
    | abs (height l - height r) > 1 = False
    | not (balanced l) = False
    | not (balanced r) = False
    | otherwise = True

findUnbalancedNode :: (Ord a) => AVLTree a -> Maybe [Direction]
findUnbalancedNode Nil = Nothing
findUnbalancedNode t@(Node v l r)
    | balanced t = Nothing
    | not (balanced t) && balanced l && balanced r = Just []
    | balanced l = fmap (R :) (findUnbalancedNode r)
    | otherwise = fmap (L :) (findUnbalancedNode l)

rightTree :: AVLTree a -> AVLTree a
rightTree Nil = Nil
rightTree (Node _ _ r) = r

leftTree :: AVLTree a -> AVLTree a
leftTree Nil = Nil
leftTree (Node _ l _) = l

keyValue :: AVLTree a -> a
keyValue (Node v _ _) = v
keyValue Nil = error "no value"

-- Rotations, @evgenii-malov
rotateR :: (Ord a) => AVLTree a -> AVLTree a
rotateR (Node e l (Node er lr rr)) = Node er (Node e l lr) rr

rotateL :: (Ord a) => AVLTree a -> AVLTree a
rotateL (Node e (Node el ll rl) r) = Node el ll (Node e rl r)

rotateLR :: (Ord a) => AVLTree a -> AVLTree a
rotateLR (Node e (Node el ll (Node elr lrl lrr)) r) = Node elr (Node el ll lrl) (Node e lrr r)

rotateRL :: (Ord a) => AVLTree a -> AVLTree a
rotateRL (Node e l (Node er (Node erl rll rlr) rr)) = Node erl (Node e l rll) (Node er rlr rr)

rotateNode :: (Ord a) => AVLTree a -> AVLTree a
rotateNode Nil = Nil
rotateNode t@(Node _ l r)
    | balanceFactor < -1 && height (left r) < height (right r) -- SR RR
        =
        trace "Rotation R" rotateR t
    | balanceFactor > 1 && height (right l) < height (left l) -- SR LL
        =
        trace "Rotation L" rotateL t
    | balanceFactor < -1 && height (left r) > height (right r) -- DR RL
        =
        trace "Rotation RL" rotateRL t
    | balanceFactor > 1 && height (right l) > height (left l) -- DR LR
        =
        trace "Rotation LR" rotateLR t
  where
    balanceFactor = height l - height r

rotateAt :: (Ord a) => AVLTree a -> Maybe [Direction] -> AVLTree a
rotateAt t Nothing = t
rotateAt (Node v l r) (Just (d : ds)) = case d of
    R -> Node v l (rotateAt r (Just ds))
    L -> Node v (rotateAt l (Just ds)) r
rotateAt t (Just []) = rotateNode t

-- insert without balance
insert' :: (Ord a) => a -> AVLTree a -> AVLTree a
insert' v Nil = Node v Nil Nil
insert' v' (Node v l r)
    | v <= v' = Node v l (insert' v' r)
    | otherwise = Node v (insert' v' l) r

insert :: (Ord a) => a -> AVLTree a -> AVLTree a
insert v t =
    let treeAfterInsertion = insert' v t
     in rotateAt treeAfterInsertion (findUnbalancedNode treeAfterInsertion)

-- pending node remotion
-- remove :: (Ord a) => a -> AVLTree a -> AVLTree a
-- remove _ Nil = Nil
-- remove n (Node v Nil Nil)
--     | n == v = Nil
--     | otherwise = Node v Nil Nil
-- remove n (Node k l r)
--     | n <= k = remove n l
--     | otherwise = remove n r
