module Selector.OrderLine exposing (..)

import Data.OrderLine exposing (OrderLine, OrderLineId)
import Data.Product exposing (Product, defaultProduct)
import Store.Main exposing (Store)
import Store.OrderLineStore exposing (getOrderLine)
import Store.ProductStore exposing (getProduct)
import Util exposing ((=>))


orderLineSelector : OrderLineId -> Store -> Maybe ( OrderLine, Product )
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
    Maybe.map2 (=>) orderLine product
