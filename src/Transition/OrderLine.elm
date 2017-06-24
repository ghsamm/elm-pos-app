module Transition.OrderLine exposing (..)

import Data.Discount exposing (Discount)
import Data.OrderLine exposing (OrderLine)


applyDiscount : Discount -> OrderLine -> OrderLine
applyDiscount discount orderLine =
    { orderLine
        | discount = Just discount
    }


setProductQuantity : Int -> OrderLine -> OrderLine
setProductQuantity newQuantity orderLine =
    { orderLine
        | quantity = newQuantity
    }


incrementQuantity : OrderLine -> OrderLine
incrementQuantity orderLine =
    setProductQuantity (orderLine.quantity + 1) orderLine
