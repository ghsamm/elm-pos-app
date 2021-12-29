module Selector.OrderLine exposing (orderLineListSelector, orderLinePrice, orderLineQuantity, orderLineSelector, selectedOrderLine)

import Data.Model exposing (Model)
import Data.OrderLine as OrderLine exposing (OrderLine, OrderLineId)
import Data.OrderLineStore exposing (getOrderLine)
import Data.Product exposing (Product)
import Data.ProductStore exposing (getProduct)
import Tuple exposing (pair)


selectedOrderLine : Model -> Maybe OrderLine
selectedOrderLine model =
    model.orderLineStore.selectedOrderLine
        |> Maybe.andThen (\selectedOrderLineId -> orderLineSelector selectedOrderLineId model)
        |> Maybe.map Tuple.first


orderLinePrice : OrderLineId -> Model -> Float
orderLinePrice orderLineId model =
    let
        maybeOrderLine =
            orderLineSelector orderLineId model
    in
    case maybeOrderLine of
        Nothing ->
            0

        Just ( orderLine, product ) ->
            toFloat
                (orderLine |> OrderLine.toQuantity)


orderLineQuantity : OrderLineId -> Model -> Int
orderLineQuantity orderLineId model =
    let
        maybeOrderLine =
            orderLineSelector orderLineId model
    in
    case maybeOrderLine of
        Nothing ->
            0

        Just ( orderLine, _ ) ->
            OrderLine.toQuantity orderLine


orderLineSelector : OrderLineId -> Model -> Maybe ( OrderLine, Product )
orderLineSelector orderLineId model =
    let
        maybeOrderLine : Maybe OrderLine
        maybeOrderLine =
            getOrderLine orderLineId model.orderLineStore

        product : Maybe Product
        product =
            maybeOrderLine
                |> Maybe.andThen
                    (\orderLine ->
                        getProduct (orderLine |> OrderLine.toProductId) model.productStore
                    )
    in
    Maybe.map2 pair maybeOrderLine product


orderLineListSelector : List OrderLineId -> Model -> List ( OrderLine, Product )
orderLineListSelector orderLineIdList model =
    let
        foldFunction cur res =
            case cur of
                Just val ->
                    val :: res

                Nothing ->
                    res
    in
    orderLineIdList
        |> List.map (\id -> orderLineSelector id model)
        |> List.foldl foldFunction []
