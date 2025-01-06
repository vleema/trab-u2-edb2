module AVLTree.Core where

import Data.Bits (Bits (rotate))
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

rotateAt :: (Ord a) => AVLTree a -> Maybe [Direction] -> AVLTree a
rotateAt t Nothing = t
rotateAt (Node v l r) (Just (d :: ds)) = case d of
    R -> Node v l (rotateAt r (Just ds))
    L -> Node v (rotateAt l Just ds) r
rotateAt (Node v l r) (Just []) = undefined -- é pra rotacionar aqui, agora é só ver qual rotação usar

-- insert without balance
insert' :: (Ord a) => AVLTree a -> a -> AVLTree a
insert' Nil v = Node v Nil Nil
insert' (Node v l r) v'
    | v <= v' = Node v l (insert' r v')
    | otherwise = Node v (insert' l v') r

balance :: (Ord a) => AVLTree a -> AVLTree a
balance Nil = Nil
balance t@(Node v l r) = rotateA

insert :: (Ord a) => AVLTree a -> a -> AVLTree a
insert v t = balance (insert' v t)
