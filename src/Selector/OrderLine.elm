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
        |> Maybe.andThen (\selectedOrderLineId -> Result.toMaybe <| orderLineSelector selectedOrderLineId model)
        |> Maybe.map Tuple.first


orderLinePrice : OrderLineId -> Model -> Float
orderLinePrice orderLineId model =
    let
        orderLine =
            orderLineSelector orderLineId model
    in
    case orderLine of
        Err _ ->
            0

        Ok ( orderLine, product ) ->
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
        Err _ ->
            0

        Ok ( orderLine, _ ) ->
            OrderLine.toQuantity orderLine


orderLineSelector : OrderLineId -> Model -> Result OrderLineErr ( OrderLine, Product )
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
    case ( orderLine, product ) of
        ( Nothing, Nothing ) ->
            Err OrderLineNotFound

        ( Nothing, Just _ ) ->
            Err OrderLineNotFound

        ( Just _, Nothing ) ->
            Err ProductNotFound

        ( Just orderLine, Just product ) ->
            Ok ( orderLine, product )
