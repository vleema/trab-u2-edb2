module AVLTree.Core where

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

rotateRight :: (Ord a) => AVLTree a -> AVLTree a
rotateRight Nil = Nil
rotateRight t =
    let l = leftTree t
        r = rightTree t
     in case l of
            Nil -> t
            Node _ ll lr -> Node (keyValue l) ll (Node (keyValue t) lr r)

rotateLeft :: (Ord a) => AVLTree a -> AVLTree a
rotateLeft Nil = Nil
rotateLeft t =
    let l = leftTree t
        r = rightTree t
     in case r of
            Nil -> t
            Node _ rl rr -> Node (keyValue r) (Node (keyValue t) l rl) rr

insert :: (Ord a) => AVLTree a -> a -> AVLTree a
insert Nil v = Node v Nil Nil
insert (Node v l r) v' = undefined

delete :: (Ord a) => AVLTree a -> a -> AVLTree a
delete = undefined

exampleTree1 :: AVLTree Int
exampleTree1 =
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

exampleTree2 :: AVLTree Int
exampleTree2 =
    Node
        10
        ( Node
            5
            ( Node
                3
                ( Node
                    1
                    Nil
                    Nil
                )
                Nil
            )
            Nil
        )
        (Node 15 Nil Nil)

{-
        10
       /  \
      5    15
     /
    3
   /
  1
-}

exampleTree3 :: AVLTree Int
exampleTree3 =
    Node
        10
        ( Node
            5
            ( Node
                3
                Nil
                Nil
            )
            Nil
        )
        Nil

{-
        10
       /
      5
     /
    3
-}

exampleTree4 :: AVLTree Int
exampleTree4 =
    Node
        3
        Nil
        ( Node
            5
            Nil
            ( Node
                10
                Nil
                Nil
            )
        )

{-
   3
    \
     5
      \
       10
-}
