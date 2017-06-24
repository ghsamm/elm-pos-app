module Store.OrderLineStore exposing (..)

import Data.OrderLine exposing (OrderLine, OrderLineId(..), orderLineIdToString)
import Dict exposing (Dict)


type alias OrderLineStore =
    Dict String OrderLine


getOrderLine : OrderLineId -> OrderLineStore -> Maybe OrderLine
getOrderLine orderLineId orderLineStore =
    Dict.get (orderLineIdToString orderLineId) orderLineStore
