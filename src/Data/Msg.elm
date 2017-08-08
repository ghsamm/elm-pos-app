module Data.Msg exposing (..)

import Data.OrderLineStore exposing (OrderLineStoreMsg)
import Data.ProductStore exposing (ProductStoreMsg)


type Msg
    = NoOp
    | ProductStoreMsg ProductStoreMsg
    | OrderLineStoreMsg OrderLineStoreMsg
