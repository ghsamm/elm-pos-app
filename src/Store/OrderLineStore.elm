module Store.OrderLineStore exposing (..)

import Data.OrderLine exposing (OrderLine, OrderLineId(..), orderLineIdToString)
import Dict exposing (Dict)
import Util exposing (storeFromList)


type alias OrderLineStore =
    Dict String OrderLine


fromList : List OrderLine -> OrderLineStore
fromList =
    storeFromList (.id >> orderLineIdToString)


getOrderLine : OrderLineId -> OrderLineStore -> Maybe OrderLine
getOrderLine orderLineId orderLineStore =
    Dict.get (orderLineIdToString orderLineId) orderLineStore
