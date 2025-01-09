module RBTree.Show where

import RBTree.Core

import Data.List (intercalate)

data ParentDir = PLeft | PRight | NoParent deriving (Show, Eq)
type ParentPos = Int
type Level = Int

dline = '|'
factor = 4

m c1 c2 = if c1 == dline then c1 else c2
zipWith' f xs [] = xs
zipWith' f [] xs = xs
zipWith' f (x : xs) (y : ys) = f x y : zipWith' f xs ys

buildLine pd color a pp level = foldl (zipWith' m) "" ((((++ "|") . flip replicate ' ') . (factor *) <$> pp) ++ [replicate (factor * level) ' ' ++ cn ++ colorize (show a)])
 where
  cn = case pd of
    PLeft -> "└──"
    PRight -> "┌──"
    NoParent -> "───"
  colorize = case color of
    Red -> red
    Black -> black

prettyPrint' :: (Show a) => ParentDir -> [ParentPos] -> Level -> RBTree a -> [String]
prettyPrint' _ _ _ Nil = []
prettyPrint' _ _ _ NNil = ["WTF"]
prettyPrint' pd pp level (Node color l a r) =
  prettyPrint' PRight new_pp_r (level + 1) r
    ++ [buildLine pd color a pp level]
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

p t = putStrLn (intercalate "\n" (prettyPrint' NoParent [] 0 t))

red :: String -> String
red text = "\x1b[31m" ++ text ++ "\x1b[0m"

black :: String -> String
black text = "\x1b[90m" ++ text ++ "\x1b[0m"
