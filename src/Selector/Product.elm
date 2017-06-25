module Selector.Product exposing (..)

import Data.Product exposing (Product, ProductErr(..), ProductId)
import Store.Main exposing (Store)
import Store.ProductStore exposing (getProduct)


productSelector : ProductId -> Store -> Result ProductErr Product
productSelector productId store =
    let
        product =
            getProduct productId store.products
    in
    case product of
        Nothing ->
            Err ProductNotFound

        Just product ->
            Ok product
