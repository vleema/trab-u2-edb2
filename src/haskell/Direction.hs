module Direction where

data Direction = L | R
  deriving (Show, Eq)

type Path = [Direction]
