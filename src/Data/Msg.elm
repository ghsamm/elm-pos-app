module Data.Msg exposing (..)

import Data.OrderLine exposing (OrderLineId)


type Msg
    = NoOp
    | SelectOrderLine OrderLineId
    | SearchProduct String
