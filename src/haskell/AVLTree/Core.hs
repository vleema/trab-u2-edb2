module AVLTree where

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

insert :: (Ord a) => AVLTree a -> a -> AVLTree a
insert = undefined

search :: (Ord a) => AVLTree a -> a -> Maybe [Direction]
search Nil _ = trace "base" Nothing
search (Node k l r) v
  | v == k = Just []
  | v <= k = fmap (L :) (search l v) -- fmap :: (Ldir -> Ldir) -> (MLdir -> MLdir)
  | otherwise = fmap (R :) (search r v)

delete :: (Ord a) => AVLTree a -> a -> AVLTree a
delete = undefined

exampleTree3 :: AVLTree Int
exampleTree3 =
  Node
    10
    ( Node
        5
        (Node 3 Nil Nil)
        (Node 7 Nil Nil)
    )
    ( Node
        15
        (Node 12 Nil Nil)
        (Node 18 Nil Nil)
    )

{-
        10
       /  \
      5    15
     / \   / \
    3   7 12 18
-}
