module Halogen.Themes.Framework7.Indexed
  ( dataPage
  , dataSearchList
  , module F7C
  ) where

import Prelude

import Halogen.HTML.Properties.Indexed (IProp(..))
import Halogen.Themes.Framework7 as HF7
import Halogen.Themes.Framework7.Classes as F7C

dataPage :: forall t0 t1. String -> IProp t0 t1
dataPage = IProp <<< HF7.dataPage

dataSearchList :: forall t0 t1. String -> IProp t0 t1
dataSearchList = IProp <<< HF7.dataSearchList
