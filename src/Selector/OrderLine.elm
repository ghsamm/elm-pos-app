module Selector.OrderLine exposing (..)

import Data.Discount exposing (applyDiscount)
import Data.Model exposing (Model)
import Data.OrderLine as OrderLine exposing (OrderLine, OrderLineErr(..), OrderLineId)
import Data.OrderLineStore exposing (getOrderLine)
import Data.Product as Product exposing (Product)
import Data.ProductStore exposing (getProduct)


selectedOrderLine : Model -> Maybe OrderLine
selectedOrderLine model =
    model.orderLineStore.selectedOrderLine
        |> Maybe.andThen (\selectedOrderLineId -> orderLineSelector selectedOrderLineId model)
        |> Maybe.map Tuple.first


orderLinePrice : OrderLineId -> Model -> Float
orderLinePrice orderLineId model =
    let
        orderLine =
            orderLineSelector orderLineId model
    in
    case orderLine of
        Nothing ->
            0

        Just ( orderLine, product ) ->
            toFloat
                (orderLine |> OrderLine.toQuantity)
                * applyDiscount
                    (orderLine |> OrderLine.toDiscount)
                    (product |> Product.toPrice)


orderLineQuantity : OrderLineId -> Model -> Int
orderLineQuantity orderLineId model =
    let
        orderLine =
            orderLineSelector orderLineId model
    in
    case orderLine of
        Nothing ->
            0

        Just ( orderLine, _ ) ->
            OrderLine.toQuantity orderLine


orderLineSelector : OrderLineId -> Model -> Maybe ( OrderLine, Product )
orderLineSelector orderLineId model =
    let
        orderLine : Maybe OrderLine
        orderLine =
            getOrderLine orderLineId model.orderLineStore

        product : Maybe Product
        product =
            orderLine
                |> Maybe.andThen
                    (\orderLine ->
                        getProduct (orderLine |> OrderLine.toProductId) model.productStore
                    )
    in
    Maybe.map2 (,) orderLine product


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
