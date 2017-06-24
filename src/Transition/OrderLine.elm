module Transition.OrderLine exposing (..)

import Data.Discount exposing (Discount)
import Data.OrderLine exposing (OrderLine)


applyDiscount : Discount -> OrderLine -> OrderLine
applyDiscount discount orderLine =
    { orderLine
        | discount = Just discount
    }
