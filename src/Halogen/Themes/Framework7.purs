module Halogen.Themes.Framework7
  ( dataPage
  , dataSearchList
  , module Halogen.Themes.Framework7.Classes
  ) where

import Data.Maybe (Maybe(..))

import Halogen.HTML (Prop(..), attrName)
import Halogen.Themes.Framework7.Classes

dataPage :: forall t. String -> Prop t
dataPage p = Attr Nothing (attrName "data-page") p

dataSearchList :: forall t. String -> Prop t
dataSearchList p = Attr Nothing (attrName "data-search-list") p
