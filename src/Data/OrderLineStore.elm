module Data.OrderLineStore exposing (..)

import Data.OrderLine as OrderLine exposing (OrderLine, OrderLineId(..), orderLineIdToString)
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


updateSelectedOrderLine : (Maybe OrderLine -> Maybe OrderLine) -> OrderLineStore -> OrderLineStore
updateSelectedOrderLine callback orderLineStore =
    orderLineStore.selectedOrderLine
        |> Maybe.map OrderLine.orderLineIdToString
        |> Maybe.map
            (\selectedId ->
                { orderLineStore
                    | orderLines = Dict.update selectedId callback orderLineStore.orderLines
                }
            )
        |> Maybe.withDefault orderLineStore


update : OrderLineStoreMsg -> OrderLineStore -> OrderLineStore
update msg orderLineStore =
    case msg of
        SelectOrderLine orderLineId ->
            { orderLineStore | selectedOrderLine = Just orderLineId }

        SetCurrentOrderLineQuantity newQuantity ->
            updateSelectedOrderLine
                (\maybeOrderline ->
                    maybeOrderline
                        |> Maybe.map (\orderLine -> OrderLine.withQuantity newQuantity orderLine)
                )
                orderLineStore


fromList : List OrderLine -> OrderLineStore
fromList orderLineList =
    { orderLines = listToDict (OrderLine.toId >> orderLineIdToString) orderLineList
    , selectedOrderLine = Nothing
    }


getOrderLine : OrderLineId -> OrderLineStore -> Maybe OrderLine
getOrderLine orderLineId orderLineStore =
    Dict.get (orderLineIdToString orderLineId) orderLineStore.orderLines


addProduct : Product -> OrderLineStore -> OrderLineStore
addProduct product orderLineStore =
    let
        newOrderLine =
            OrderLine.fromId "fff"
                |> OrderLine.withProductId (product |> Product.toId)
    in
    { orderLineStore | orderLines = Dict.insert "ffff" newOrderLine orderLineStore.orderLines }
