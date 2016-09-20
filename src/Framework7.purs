-- | Provides low-level access to version 1.4.2 of the Framework7 mobile UI
-- | framework.
-- |
-- | See https://framework7.io/docs for full documentation of the underlying
-- | API.
module Framework7 where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)

foreign import data Framework7 :: *
foreign import data View :: *
foreign import data Searchbar :: *

type InitializeParameters =
  { material :: Boolean
  }

-- | Initializes Framework7 using the specified parameters.
-- |
-- | This wraps `new Framework7`.
foreign import initialize :: forall eff. InitializeParameters -> Eff (err :: EXCEPTION | eff) Framework7

-- | Adds a new view.
-- |
-- | This wraps `Framework7.addView()`.
foreign import addView :: forall eff. Framework7 -> String -> Eff (err :: EXCEPTION | eff) View

-- | Initializes a searchbar.
-- |
-- | This wraps `Framework7.searchbar()`.
foreign import searchbar :: forall eff. Framework7 -> String -> Eff (err :: EXCEPTION | eff) Searchbar

-- | Shows the specified tab.
-- |
-- | This wraps `Framework7.showTab()`.
foreign import showTab :: forall eff. Framework7 -> String -> Eff (err :: EXCEPTION | eff) Boolean

-- | Loads a page (specified by its `data-page` value) in a view.
-- |
-- | This wraps `View.router.load()`.
foreign import routerLoad :: forall eff. View -> String -> Boolean -> Eff (err :: EXCEPTION | eff) Unit

-- | Moves a view back one page in its history.
-- |
-- | This wraps `View.router.back()`.
foreign import routerBack :: forall eff. View -> Eff (err :: EXCEPTION | eff) Unit

-- | Given a view and an action, creates an event handler which routes the view
-- | back one page, or runs the acion if there is no page to go back to.
foreign import backButtonHandler :: forall eff. View -> Eff eff Unit -> Eff (err :: EXCEPTION | eff) Unit
