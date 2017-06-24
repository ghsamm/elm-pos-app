module Selector.OrderLine exposing (..)

import Data.OrderLine exposing (OrderLine)
import Data.Product exposing (Product, defaultProduct)
import Dict exposing (get)
import Store.Main exposing (Store)


orderLineSelector : OrderLine -> Store -> ( OrderLine, Product )
orderLineSelector orderLine store =
    let
        product =
            Maybe.withDefault Produt.defaultProduct Dict.get orderLine.productId store.products
    in
    ( orderLine, product )
