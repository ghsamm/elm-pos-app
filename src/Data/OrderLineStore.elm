module Data.OrderLineStore exposing (..)

import Data.OrderLine as OrderLine exposing (OrderLine, OrderLineId(..), orderLineIdToString)
import Data.Product as Product exposing (Product)
import Dict exposing (Dict, insert)
import Util exposing (storeFromList)


type alias OrderLineStore =
    Dict String OrderLine


fromList : List OrderLine -> OrderLineStore
fromList =
    storeFromList (OrderLine.toId >> orderLineIdToString)


getOrderLine : OrderLineId -> OrderLineStore -> Maybe OrderLine
getOrderLine orderLineId orderLineStore =
    Dict.get (orderLineIdToString orderLineId) orderLineStore


addProduct : Product -> OrderLineStore -> OrderLineStore
addProduct product orderLineStore =
    let
        newOrderLine =
            OrderLine.fromId "fff"
                |> OrderLine.withProductId (product |> Product.toId)
    in
    Dict.insert "ffff" newOrderLine orderLineStore
