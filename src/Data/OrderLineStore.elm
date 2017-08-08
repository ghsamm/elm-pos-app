module Data.OrderLineStore exposing (..)

import Data.OrderLine as OrderLine exposing (OrderLine, OrderLineId(..))
import Data.Product as Product exposing (Product)
import Dict exposing (Dict, insert)
import Util exposing (listToDict)


type alias OrderLineStore =
    { orderLines : Dict String OrderLine
    , selectedOrderLine : Maybe OrderLineId
    }


type OrderLineStoreMsg
    = SelectOrderLine OrderLineId
    | SetCurrentOrderLineQuantity Int


updateOderLine : OrderLineId -> (OrderLine -> OrderLine) -> OrderLineStore -> OrderLineStore
updateOderLine (OrderLineId orderLineId) updater orderLineStore =
    { orderLineStore
        | orderLines = Dict.update orderLineId (Maybe.map updater) orderLineStore.orderLines
    }


updateSelectedOrderLine : (OrderLine -> OrderLine) -> OrderLineStore -> OrderLineStore
updateSelectedOrderLine updater orderLineStore =
    case orderLineStore.selectedOrderLine of
        Just selectedOrderLine ->
            updateOderLine selectedOrderLine updater orderLineStore

        Nothing ->
            orderLineStore


update : OrderLineStoreMsg -> OrderLineStore -> OrderLineStore
update msg orderLineStore =
    case msg of
        SelectOrderLine orderLineId ->
            { orderLineStore | selectedOrderLine = Just orderLineId }

        SetCurrentOrderLineQuantity newQuantity ->
            updateSelectedOrderLine
                (OrderLine.withQuantity newQuantity)
                orderLineStore


fromList : List OrderLine -> OrderLineStore
fromList orderLineList =
    { orderLines = listToDict (OrderLine.toId >> (\(OrderLineId orderLineId) -> orderLineId)) orderLineList
    , selectedOrderLine = Nothing
    }


getOrderLine : OrderLineId -> OrderLineStore -> Maybe OrderLine
getOrderLine (OrderLineId orderLineId) orderLineStore =
    Dict.get orderLineId orderLineStore.orderLines


addProduct : Product -> OrderLineStore -> OrderLineStore
addProduct product orderLineStore =
    let
        newOrderLine =
            OrderLine.fromId "fff"
                |> OrderLine.withProductId (product |> Product.toId)
    in
    { orderLineStore | orderLines = Dict.insert "ffff" newOrderLine orderLineStore.orderLines }
