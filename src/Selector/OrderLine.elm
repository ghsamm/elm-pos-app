module Selector.OrderLine exposing (..)

import Data.Discount exposing (applyDiscount)
import Data.Model exposing (Model)
import Data.OrderLine exposing (OrderLine, OrderLineErr(..), OrderLineId)
import Data.OrderLineStore exposing (getOrderLine)
import Data.Product as Product exposing (Product)
import Data.ProductStore exposing (getProduct)


orderLinePrice : OrderLineId -> Model -> Float
orderLinePrice orderLineId store =
    let
        orderLine =
            orderLineSelector orderLineId store
    in
    case orderLine of
        Err _ ->
            0

        Ok ( orderLine, product ) ->
            toFloat
                orderLine.quantity
                * applyDiscount
                    orderLine.discount
                    (product |> Product.toPrice)


orderLineSelector : OrderLineId -> Model -> Result OrderLineErr ( OrderLine, Product )
orderLineSelector orderLineId store =
    let
        orderLine : Maybe OrderLine
        orderLine =
            getOrderLine orderLineId store.orderLines

        product : Maybe Product
        product =
            orderLine
                |> Maybe.andThen
                    (\orderLine ->
                        getProduct orderLine.productId store.products
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
