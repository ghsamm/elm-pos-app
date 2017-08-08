module Data.Msg exposing (..)

import Data.OrderLineStore exposing (OrderLineStoreMsg)
import Data.Product exposing (ProductId)


type Msg
    = NoOp
    | SearchProduct String
    | AddProductToLineOrderList ProductId
    | OrderLineStoreMsg OrderLineStoreMsg
