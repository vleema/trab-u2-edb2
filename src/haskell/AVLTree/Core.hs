module AVLTree.Core where

import Data.IntMap (insert)
import Debug.Trace
import Direction
import Prelude hiding (

 )

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

rightTree :: AVLTree a -> AVLTree a
rightTree Nil = Nil
rightTree (Node _ _ r) = r

leftTree :: AVLTree a -> AVLTree a
leftTree Nil = Nil
leftTree (Node _ l _) = l

keyValue :: AVLTree a -> a
keyValue (Node v _ _) = v
keyValue Nil = error "no value"

-- so far just working for straight trees, i.e.
{- leftUnbalanced
        10
       /         5
      5    =>   / \
     /         3  10
    3
-}
-- TODO: make works for non-straight trees
{-
   1       1
    \       \
     3  =>   2
    /         \
   2           3
-}
rotateRight :: (Ord a) => AVLTree a -> AVLTree a
rotateRight Nil = Nil
rotateRight t =
    let l = leftTree t
        r = rightTree t
     in case l of
            Nil -> t
            Node _ ll lr -> Node (keyValue l) ll (Node (keyValue t) lr r)

-- so far just working for straight trees i.e.
{- rightUnbalanced
   3
    \           5
     5    =>   / \
      \       3  10
       10
-}
-- TODO: make works for non-straight trees
{-
   3         3
  /         /
 1    =>   2
  \       /
   2     1
-}
rotateLeft :: (Ord a) => AVLTree a -> AVLTree a
rotateLeft Nil = Nil
rotateLeft t =
    let l = leftTree t
        r = rightTree t
     in case r of
            Nil -> t
            Node _ rl rr -> Node (keyValue r) (Node (keyValue t) l rl) rr

-- insert without balance
insert' :: (Ord a) => AVLTree a -> a -> AVLTree a
insert' Nil v = Node v Nil Nil
insert' (Node v l r) v'
    | v <= v' = Node v l (insert' r v')
    | otherwise = Node v (insert' l v') r

balance :: (Ord a) => AVLTree a -> AVLTree a
balance Nil = Nil
balance t
    | balanced t = t
    | not $ balanced $ leftTree t = t

delete :: (Ord a) => AVLTree a -> a -> AVLTree a
delete = undefined
