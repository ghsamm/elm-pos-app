module Data.Msg exposing (..)

import Data.OrderLineStore exposing (OrderLineStoreMsg)


type Msg
    = NoOp
      -- | SearchProduct String
    | OrderLineStoreMsg OrderLineStoreMsg
