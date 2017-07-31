module Data.Msg exposing (..)

import Data.OrderLine exposing (OrderLineId)
import Data.Product exposing (ProductId)


type Msg
    = NoOp
    | SelectOrderLine OrderLineId
    | SearchProduct String
    | AddProductToLineOrderList ProductId
    | SetCurrentOrderLineQuantity Int
