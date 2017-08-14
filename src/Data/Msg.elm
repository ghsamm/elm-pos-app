module Data.Msg exposing (..)

import Data.OrderLineStore exposing (OrderLineStoreMsg)
import Data.ProductStore exposing (ProductStoreMsg)
import Data.TagStore exposing (TagStoreMsg)


type Msg
    = NoOp
    | ProductStoreMsg ProductStoreMsg
    | OrderLineStoreMsg OrderLineStoreMsg
    | TagStoreMsg TagStoreMsg
