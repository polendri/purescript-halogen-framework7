module Halogen.Themes.Framework7.Indexed
  ( dataPage
  , dataPanel
  , dataPopup
  , dataSearchList
  , module F7C
  ) where

import Prelude

import Halogen.HTML.Properties.Indexed (IProp(..))
import Halogen.Themes.Framework7 as HF7
import Halogen.Themes.Framework7.Classes as F7C

dataPage :: forall t0 t1. String -> IProp t0 t1
dataPage = IProp <<< HF7.dataPage

dataPanel :: forall t0 t1. String -> IProp t0 t1
dataPanel = IProp <<< HF7.dataPanel

dataPopup :: forall t0 t1. String -> IProp t0 t1
dataPopup = IProp <<< HF7.dataPopup

dataSearchList :: forall t0 t1. String -> IProp t0 t1
dataSearchList = IProp <<< HF7.dataSearchList
