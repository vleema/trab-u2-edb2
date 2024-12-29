module AVLTree.Show where

import AVLTree.Core
import Data.List

data ParentDir = PLeft | PRight | NoParent deriving (Show, Eq)
type ParentPos = Int
type Level = Int

dline = '|'
factor = 4

m c1 c2 = if c1 == dline then c1 else c2
zipWith' f xs [] = xs
zipWith' f [] xs = xs
zipWith' f (x : xs) (y : ys) = f x y : zipWith' f xs ys

buildLine pd a pp level = foldl (zipWith' m) "" ((((++ "|") . flip replicate ' ') . (factor *) <$> pp) ++ [replicate (factor * level) ' ' ++ cn ++ show a])
  where
    cn = case pd of
        PLeft -> "└──"
        PRight -> "┌──"
        NoParent -> "───"

prettyPrint' :: (Show a) => ParentDir -> [ParentPos] -> Level -> AVLTree a -> [String]
prettyPrint' _ _ _ Nil = []
prettyPrint' pd pp level (Node a l r) =
    prettyPrint' PRight new_pp_r (level + 1) r
        ++ [buildLine pd a pp level]
        ++ prettyPrint' PLeft new_pp_l (level + 1) l
  where
    new_pp_r = case pd of
        PRight -> pp
        PLeft -> pp ++ [level]
        NoParent -> pp
    new_pp_l = case pd of
        PRight -> pp ++ [level]
        PLeft -> pp
        NoParent -> pp

prettyPrint t = putStrLn (intercalate "\n" (prettyPrint' NoParent [] 0 t))
