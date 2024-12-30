module AVLTree.Examples where

import AVLTree.Core

balancedTree :: AVLTree Int
balancedTree =
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

unbalancedTree :: AVLTree Int
unbalancedTree =
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

unbalanced2 :: AVLTree Int
unbalanced2 =
    Node
        3
        ( Node
            1
            Nil
            Nil
        )
        ( Node
            5
            Nil
            ( Node
                10
                Nil
                ( Node
                    11
                    Nil
                    Nil
                )
            )
        )

{-
   3
  / \
 1   5
      \
       10
        \
         11
-}
-- left unbalanced, need a right rotation
leftUnbalanced :: AVLTree Int
leftUnbalanced =
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

-- right unbalanced, need a left rotation
rightUnbalanced :: AVLTree Int
rightUnbalanced =
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
needLR :: AVLTree Int
needLR =
    Node
        3
        ( Node
            1
            Nil
            ( Node
                2
                Nil
                Nil
            )
        )
        Nil

{-
   3
  /
 1
  \
   2
-}

needRL :: AVLTree Int
needRL =
    Node
        1
        Nil
        ( Node
            3
            ( Node
                2
                Nil
                Nil
            )
            Nil
        )

{-
   1
    \
     3
    /
   2
-}
