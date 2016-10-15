-- | Provides low-level access to version 1.4.2 of the Framework7 mobile UI
-- | framework.
-- |
-- | See https://framework7.io/docs for full documentation of the underlying
-- | API.
module Framework7
  ( Framework7
  , InitializeParameters
  , Notification
  , NotificationButton
  , NotificationParameters
  , Searchbar
  , View
  , addNotification
  , addView
  , backButtonHandler
  , closeNotification
  , defaultInitializeParameters
  , defaultNotificationParameters
  , initialize
  , routerBack
  , routerLoad
  , searchbar
  , showTab
  ) where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Foreign (Foreign, writeObject)
import Data.Foreign.Class (write, writeProp)
import Data.Foreign.Null (Null(..), writeNull)
import Data.Maybe (Maybe(..))

foreign import data Framework7 :: *
foreign import data View :: *
foreign import data Searchbar :: *
foreign import data Notification :: *

type InitializeParameters =
  { material :: Boolean
  , materialPageLoadDelay :: Number
  , materialRipple :: Boolean
  , materialRippleElements :: String
  , materialPreloaderHTML :: String
  , cache :: Boolean
  , cacheDuration :: Number
  , cacheIgnore :: Array String
  , cacheIgnoreGetParameter :: Boolean
  , fastClicks :: Boolean
  , fastClicksDelayBetweenClicks :: Number
  , fastClicksDistanceThreshold :: Number
  , activeState :: Boolean
  , activeStateElements :: String
  , tapHold :: Boolean
  , tapHoldDelay :: Number
  , tapHoldPreventClicks :: Boolean
  }

defaultInitializeParameters :: InitializeParameters
defaultInitializeParameters =
  { material: false
  , materialPageLoadDelay: 0.0
  , materialRipple: true
  , materialRippleElements: ".ripple, a.link, a.item-link, .button, .modal-button, .tab-link, .label-radio, .label-checkbox, .actions-modal-button, a.searchbar-clear, .floating-button"
  , materialPreloaderHTML: "<span class=\"preloader-inner\"><span class=\"preloader-inner-gap\"></span><span class=\"preloader-inner-left\"><span class=\"preloader-inner-half-circle\"></span></span><span class=\"preloader-inner-right\"><span class=\"preloader-inner-half-circle\"></span></span></span>"
  , cache: true
  , cacheDuration: 600000.0
  , cacheIgnore: []
  , cacheIgnoreGetParameter: false
  , fastClicks: true
  , fastClicksDelayBetweenClicks: 50.0
  , fastClicksDistanceThreshold: 10.0
  , activeState: true
  , activeStateElements: "a, button, label, span"
  , tapHold: false
  , tapHoldDelay: 750.0
  , tapHoldPreventClicks: true
  }

type NotificationButton =
  { text :: String
  , color :: String
  , close :: Boolean
  }

type NotificationParameters =
  { message :: String
  , title :: Maybe String
  , subtitle :: Maybe String
  , media :: Maybe String
  , hold :: Maybe Number
  , closeIcon :: Boolean
  , button :: Maybe NotificationButton
  , closeOnClick :: Boolean
  , additionalClass :: Maybe String
  , custom :: Maybe String
  --onClick
  --onClose
  }

defaultNotificationParameters :: NotificationParameters
defaultNotificationParameters =
  { message: ""
  , title: Nothing
  , subtitle: Nothing
  , media: Nothing
  , hold: Nothing
  , closeIcon: true
  , button: Nothing
  , closeOnClick: false
  , additionalClass: Nothing
  , custom: Nothing
  }

type ForeignNotificationParameters =
  { message :: String
  , title :: Foreign
  , subtitle :: Foreign
  , media :: Foreign
  , hold :: Foreign
  , closeIcon :: Boolean
  , button :: Foreign
  , closeOnClick :: Boolean
  , additionalClass :: Foreign
  , custom :: Foreign
  }

toForeignNotificationParameters :: NotificationParameters -> ForeignNotificationParameters
toForeignNotificationParameters ps =
  { message: ps.message
  , title: write $ Null ps.title
  , subtitle: write $ Null ps.subtitle
  , media: write $ Null ps.media
  , hold: write $ Null ps.hold
  , closeIcon: ps.closeIcon
  , button: case ps.button of
      Nothing -> writeNull
      Just b -> writeObject [ writeProp "text" b.text, writeProp "color" b.color, writeProp "close" b.close ]
  , closeOnClick: ps.closeOnClick
  , additionalClass: write $ Null ps.additionalClass
  , custom: write $ Null ps.custom
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

foreign import addNotificationImpl :: forall eff. Framework7 -> ForeignNotificationParameters -> Eff (err :: EXCEPTION | eff) Notification

-- | Shows a notification with the specified parameters.
-- |
-- | This wraps `Framework7.addNotification()`.
addNotification :: forall eff. Framework7 -> NotificationParameters -> Eff (err :: EXCEPTION | eff) Notification
addNotification f7 ps = addNotificationImpl f7 (toForeignNotificationParameters ps)

-- | Closes the specified notification.
-- |
-- | This wraps `Framework7.closeNotification()`.
foreign import closeNotification :: forall eff. Framework7 -> Notification -> Eff (err :: EXCEPTION | eff) Unit
