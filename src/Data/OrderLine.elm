module Data.OrderLine exposing (..)

import Data.Discount exposing (Discount)
import Data.Product exposing (ProductId)


type OrderLineId
    = OrderLineId String


type alias OrderLine =
    { id : OrderLineId
    , productId : ProductId
    , quantity : Int
    , discount : Discount
    }


type OrderLineErr
    = OrderLineNotFound
    | ProductNotFound


orderLineIdToString : OrderLineId -> String
orderLineIdToString (OrderLineId orderLineId) =
    orderLineId


stringToOrderLineId : String -> OrderLineId
stringToOrderLineId orderLineId =
    OrderLineId orderLineId
