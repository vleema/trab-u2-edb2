module RedBlackTree.Core where

import Data.Either (lefts)
import Direction (Direction (..), Path)

data Color = Red | Black | DoubleBlack | NegativeBlack deriving (Eq, Show)

data RedBlackTree a
  = Node
      { color :: Color
      , left :: RedBlackTree a
      , key :: a
      , right :: RedBlackTree a
      }
  | Nil
  | DBNil

search :: (Ord a) => a -> RedBlackTree a -> Maybe Path
search _ Nil = Nothing
search value (Node _ left key right)
  | value == key = Just []
  | value < key = (L :) <$> search value left
  | value > key = (R :) <$> search value right
search _ _ = error "search: impossible"

fromList :: (Ord a) => RedBlackTree a -> [a] -> RedBlackTree a
fromList = foldr insert

-- Chris Okasaki insertion method
insert :: (Ord a) => a -> RedBlackTree a -> RedBlackTree a
insert value tree = makeRootBlack $ insert' value tree
 where
  insert' value Nil = Node Red Nil value Nil
  insert' value (Node color left key right)
    | value < key = balance color (insert' value left) key right
    | value > key = balance color left key (insert' value right)
    | otherwise = Node color left key right

-- Math Might removal method
remove :: (Ord a) => a -> RedBlackTree a -> RedBlackTree a
remove _ DBNil = error "remove: impossible"
remove _ Nil = Nil
remove value (Node color left key right)
  | value == key = delete (Node color left key right)
  | value < key = bubble color (remove value left) key right
  | otherwise = bubble color left key (remove value right)

delete :: (Ord a) => RedBlackTree a -> RedBlackTree a
delete (Node Red Nil _ Nil) = Nil
delete (Node Black Nil _ Nil) = DBNil
delete (Node Black (Node red at p bt) x Nil) = Node Black at p bt
delete (Node Black Nil x (Node Red at p bt)) = Node Black at p bt
delete (Node color left key right) =
  bubble color (removeMax left) (findMax left) right
delete _ = error "delete: impossible"

bubble :: Color -> RedBlackTree a -> a -> RedBlackTree a -> RedBlackTree a
bubble color (Node colorl at x bt) y (Node colorr ct z dt)
  | colorl == DoubleBlack || colorr == DoubleBlack =
      balance (blacken colorl) (Node (whiten colorr) at x bt) y (Node (whiten colorr) ct z dt)
bubble color at x bt = Node color at x bt

makeRootBlack :: RedBlackTree a -> RedBlackTree a
makeRootBlack (Node _ left key right) = Node Black left key right

balance :: Color -> RedBlackTree a -> a -> RedBlackTree a -> RedBlackTree a
-- Insertion cases for red violation
balance Black (Node Red (Node Red at x bt) y ct) z dt =
  Node Red (Node Black at x bt) y (Node Black ct z dt)
balance Black (Node Red at x (Node Red bt y ct)) z dt =
  Node Red (Node Black at x bt) y (Node Black ct z dt)
balance Black at x (Node Red (Node Red bt y ct) z dt) =
  Node Red (Node Black at x bt) y (Node Black ct z dt)
balance Black at x (Node Red bt y (Node Red ct z dt)) =
  Node Red (Node Black at x bt) y (Node Black ct z dt)
-- Removal cases for black violation
balance DoubleBlack (Node NegativeBlack (Node Black a w b) x (Node Black c y d)) z e =
  Node Black (balance Black (Node Red a w b) x c) y (Node Black d z e)
balance DoubleBlack a x (Node NegativeBlack (Node Black b y c) z (Node Black d w e)) =
  Node Black (Node Black a x b) y (balance Black c z (Node Red d w e))
balance DoubleBlack (Node NegativeBlack a x b) y (Node Black c z d) =
  Node Black (balance Black (Node Red a x b) y c) z d
balance DoubleBlack a x (Node NegativeBlack b y c) =
  Node Black a x (balance Black b y (Node Red c x Nil))
-- Default case
balance color left key right = Node color left key right

findMax :: RedBlackTree a -> a
findMax (Node _ _ key Nil) = key
findMax (Node _ _ _ right) = findMax right
findMax _ = error "findMax: Empty tree or invalid structure"

removeMax :: RedBlackTree a -> RedBlackTree a
removeMax (Node _ left _ Nil) = left
removeMax (Node color left key right) =
  bubble color left key (removeMax right)
removeMax _ = error "removeMax: Empty tree or invalid structure"

blacken :: Color -> Color
blacken Red = Black
blacken Black = DoubleBlack
blacken NegativeBlack = Red
blacken _ = error "Invalid color for blacken"

whiten :: Color -> Color
whiten Red = NegativeBlack
whiten Black = Red
whiten DoubleBlack = DoubleBlack
whiten _ = error "Invalid color for whiten"

{-
 - Balance cases:
 - Case 1: Left-Left (Double Red on Left Subtree)
 -
 -   Before:
 -             Z(B)
 -            /   \
 -        Y(R)     D
 -       /   \
 -    X(R)   C
 -   /   \
 -  A     B
 -
 -   After:
 -           Y(R)
 -          /   \
 -       X(B)   Z(B)
 -      /  \    /  \
 -     A    B  C    D
 -
 - Case 2: Left-Right (Double Red on Left Subtree's Right Child)
 -
 -   Before:
 -             Z(B)
 -            /   \
 -        X(R)     D
 -       /   \
 -      A     Y(R)
 -           /   \
 -          B     C
 -
 -   After:
 -           Y(R)
 -          /   \
 -       X(B)   Z(B)
 -      /  \    /  \
 -     A    B  C    D
 -
 - Case 3: Right-Left (Double Red on Right Subtree's Left Child)
 -
 -   Before:
 -             X(B)
 -            /   \
 -          A      Z(R)
 -                /   \
 -            Y(R)     D
 -           /   \
 -          B     C
 -
 -   After:
 -           Y(R)
 -          /   \
 -       X(B)   Z(B)
 -      /  \    /  \
 -     A    B  C    D
 -
 - Case 4: Right-Right (Double Red on Right Subtree)
 -
 -   Before:
 -             X(B)
 -            /   \
 -          A      Y(R)
 -                /   \
 -              B      Z(R)
 -                    /   \
 -                   C     D
 -
 -   After:
 -           Y(R)
 -          /   \
 -       X(B)   Z(B)
 -      /  \    /  \
 -     A    B  C    D
 - -}

exampleTree :: RedBlackTree Int
exampleTree = Node Black (Node Red Nil 5 Nil) 10 (Node Red Nil 15 Nil)

{-
      10(B)
     /    \
   5(R)   15(R)
 - -}

exampleTree1 :: RedBlackTree Int
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

exampleTree2 :: RedBlackTree Int
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

exampleTree3 :: RedBlackTree Int
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

exampleTree4 :: RedBlackTree Int
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

exampleTree5 :: RedBlackTree Int
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
