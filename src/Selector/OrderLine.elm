module Selector.OrderLine exposing (..)

import Data.OrderLine exposing (OrderLine, OrderLineErr(..), OrderLineId)
import Data.Product exposing (Product, defaultProduct)
import Store.Main exposing (Store)
import Store.OrderLineStore exposing (getOrderLine)
import Store.ProductStore exposing (getProduct)


orderLineSelector : OrderLineId -> Store -> Result OrderLineErr ( OrderLine, Product )
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
