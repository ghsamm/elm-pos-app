module Data.OrderLineStore exposing (..)

import Data.Discount exposing (Discount(..))
import Data.OrderLine exposing (OrderLine, OrderLineId(..), orderLineIdToString)
import Data.Product as Product exposing (Product)
import Dict exposing (Dict, insert)
import Util exposing (storeFromList)


type alias OrderLineStore =
    Dict String OrderLine


fromList : List OrderLine -> OrderLineStore
fromList =
    storeFromList (.id >> orderLineIdToString)


getOrderLine : OrderLineId -> OrderLineStore -> Maybe OrderLine
getOrderLine orderLineId orderLineStore =
    Dict.get (orderLineIdToString orderLineId) orderLineStore


addProduct : Product -> OrderLineStore -> OrderLineStore
addProduct product orderLineStore =
    let
        newOrderLine =
            OrderLine (OrderLineId "fff") (product |> Product.toId) 1 NoDiscount
    in
    Dict.insert "ffff" newOrderLine orderLineStore
