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

rotateR :: (Ord a) => AVLTree a -> AVLTree a
rotateR (Node e l (Node er lr rr)) = Node er (Node e l lr) rr

rotateL :: (Ord a) => AVLTree a -> AVLTree a
rotateL (Node e (Node el ll rl) r) = Node el ll (Node e rl r)

rotateLR :: (Ord a) => AVLTree a -> AVLTree a
rotateLR (Node e (Node el ll (Node elr lrl lrr)) r) = Node elr (Node el ll lrl) (Node e lrr r)

rotateRL :: (Ord a) => AVLTree a -> AVLTree a
rotateRL (Node e l (Node er (Node erl rll rlr) rr)) = Node erl (Node e l rll) (Node er rlr rr)

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
