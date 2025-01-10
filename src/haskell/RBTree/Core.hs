module RBTree.Core where

import Direction (Direction (L, R), Path)
import Prelude hiding (max)

data Color
  = Red
  | Black
  | BBlack -- double black
  | NBlack -- negative black
  deriving (Show)

data RBTree a
  = Nil -- black leaf
  | NNil -- double black leaf
  | Node Color (RBTree a) a (RBTree a)
  deriving (Show)

fromList :: (Ord a) => RBTree a -> [a] -> RBTree a
fromList = foldr insert

insert :: (Ord a) => a -> RBTree a -> RBTree a
insert x tree = blacken (ins tree)
 where
  ins Nil = Node Red Nil x Nil
  ins tree@(Node color left r right)
    | x < r = balance color (ins left) r right
    | x > r = balance color left r (ins right)
    | otherwise = tree

remove :: (Ord a, Show a) => a -> RBTree a -> RBTree a
remove x tree = blacken (rem tree)
 where
  rem Nil = Nil
  rem tree@(Node color left r right)
    | x < r = bubble color (rem left) r right
    | x > r = bubble color left r (rem right)
    | otherwise = remove' tree

member :: (Ord a) => a -> RBTree a -> Bool
member x Nil = False
member x (Node _ left r right)
  | x < r = member x left
  | x > r = member x right
  | otherwise = True

search :: (Ord a) => a -> RBTree a -> Maybe Path
search x Nil = Nothing
search x (Node _ left r right)
  | x < r = (L :) <$> search x left
  | x > r = (R :) <$> search x right
  | otherwise = Just []

fetch :: Path -> RBTree a -> Maybe a
fetch [] Nil = Nothing
fetch [] (Node _ left r right) = Just r
fetch (d : ds) (Node _ left r right) =
  case d of
    L -> fetch ds left
    R -> fetch ds right

max :: RBTree a -> a
max Nil = error "max: Nil tree, there's no maximum"
max (Node _ _ x Nil) = x
max (Node _ _ x right) = max right

removeMax :: RBTree a -> RBTree a
removeMax Nil = error "removeMax: Nil tree, there's no maximum"
removeMax tree@(Node _ _ _ Nil) = remove' tree
removeMax tree@(Node color left x right) = bubble color left x (removeMax right)

-- Private auxiliary functions --

remove' :: RBTree a -> RBTree a
remove' Nil = Nil
remove' (Node Red Nil _ Nil) = Nil
remove' (Node Black Nil _ Nil) = NNil
remove' (Node Black Nil _ (Node Red at x bt)) = Node Black at x bt
remove' (Node Black (Node Red at x bt) _ Nil) = Node Black at x bt
remove' (Node color left x right) = bubble color (removeMax left) (max left) right

balance :: Color -> RBTree a -> a -> RBTree a -> RBTree a
-- Red-Red violations with black root
balance Black (Node Red (Node Red at x bt) y ct) z dt = Node Red (Node Black at x bt) y (Node Black ct z dt)
balance Black (Node Red at x (Node Red bt y ct)) z dt = Node Red (Node Black at x bt) y (Node Black ct z dt)
balance Black at x (Node Red (Node Red bt y ct) z dt) = Node Red (Node Black at x bt) y (Node Black ct z dt)
balance Black at x (Node Red bt y (Node Red ct z dt)) = Node Red (Node Black at x bt) y (Node Black ct z dt)
-- Red-Red violations with double black root
balance BBlack (Node Red (Node Red at x bt) y ct) z dt = Node Black (Node Black at x bt) y (Node Black ct z dt)
balance BBlack (Node Red at x (Node Red bt y ct)) z dt = Node Black (Node Black at x bt) y (Node Black ct z dt)
balance BBlack at x (Node Red (Node Red bt y ct) z dt) = Node Black (Node Black at x bt) y (Node Black ct z dt)
balance BBlack at x (Node Red bt y (Node Red ct z dt)) = Node Black (Node Black at x bt) y (Node Black ct z dt)
-- Negative black handling
balance BBlack at x (Node NBlack (Node Black bt y ct) z dt@(Node Black _ _ _)) =
  Node Black (Node Black at x bt) y (balance Black ct z (redden dt))
balance BBlack (Node NBlack at@(Node Black _ _ _) x (Node Black bt y ct)) z dt =
  Node Black (balance Black (redden at) x bt) y (Node Black ct z dt)
balance color at x bt = Node color at x bt

-- `bubble` "bubbles" double-blackness upward:
bubble :: Color -> RBTree a -> a -> RBTree a -> RBTree a
bubble color left x right
  | isBBlack left || isBBlack right = balance (blacker color) (redder' left) x (redder' right)
  | otherwise = balance color left x right

redden :: RBTree a -> RBTree a
redden Nil = error "redden: cannot redden nil tree"
redden NNil = error "redden: cannot redden nnil tree"
redden (Node _ left key right) = Node Red left key right

blacken :: RBTree a -> RBTree a
blacken Nil = Nil
blacken NNil = Nil
blacken (Node _ left r right) = Node Black left r right

isBBlack :: RBTree a -> Bool
isBBlack NNil = True
isBBlack (Node BBlack _ _ _) = True
isBBlack _ = False

blacker :: Color -> Color
blacker Red = Black
blacker Black = BBlack
blacker NBlack = Red
blacker BBlack = error "blacker: too black, received Double Black"

redder :: Color -> Color
redder NBlack = error "redder: not black enough, received Negative Black"
redder Red = NBlack
redder Black = Red
redder BBlack = Black

blacker' :: RBTree a -> RBTree a
blacker' Nil = NNil
blacker' (Node color left x right) = Node (blacker color) left x right

redder' :: RBTree a -> RBTree a
redder' NNil = Nil
redder' (Node color left x right) = Node (redder color) left x right

exampleTree :: RBTree Int
exampleTree = Node Black (Node Red Nil 5 Nil) 10 (Node Red Nil 15 Nil)

{-
      10(B)
     /    \
   5(R)   15(R)
 - -}

exampleTree1 :: RBTree Int
exampleTree1 =
  Node
    Black
    (Node Black (Node Red Nil 2 Nil) 5 (Node Red Nil 7 Nil))
    10
    (Node Black Nil 15 (Node Red Nil 20 Nil))

{-
          10(B)
         /      \
     5(B)        15(B)
    /   \           \
  2(R)   7(R)       20(R)
 - -}

exampleTree2 :: RBTree Int
exampleTree2 =
  Node
    Black
    ( Node
        Black
        (Node Red Nil 1 Nil)
        5
        (Node Red Nil 7 Nil)
    )
    10
    ( Node
        Black
        (Node Red Nil 12 Nil)
        15
        (Node Red Nil 20 Nil)
    )

{-
               10(B)
          /            \
      5(B)              15(B)
     /   \            /      \
   1(R)   7(R)     12(R)    20(R)
 - -}

exampleTree3 :: RBTree Int
exampleTree3 =
  Node
    Black
    (Node Black Nil 1 Nil)
    5
    (Node Black Nil 10 Nil)

{-
       5(B)
      /   \
    1(B)  10(B)
- -}

exampleTree4 :: RBTree Int
exampleTree4 =
  Node
    Black
    ( Node
        Red
        (Node Black Nil 1 Nil)
        5
        (Node Black Nil 7 Nil)
    )
    10
    ( Node
        Red
        (Node Black Nil 12 Nil)
        15
        (Node Black Nil 20 Nil)
    )

{-
              10(B)
          /           \
       5(R)           15(R)
      /   \          /      \
   1(B)   7(B)    12(B)   20(B)
- -}

exampleTree5 :: RBTree Int
exampleTree5 =
  Node
    Black
    Nil
    1
    ( Node
        Red
        Nil
        2
        (Node Black Nil 3 Nil)
    )

{-
    1(B)
      \
       2(R)
         \
          3(B)
- -}

testList = [15, 18, 20, 35, 32, 38, 30, 40, 32, 45, 48, 52, 60, 50]
