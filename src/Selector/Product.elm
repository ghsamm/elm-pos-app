module Selector.Product exposing (..)

import Data.Product exposing (Product, ProductErr(..), ProductId)
import Dict exposing (Dict)
import Store.Main exposing (Store)
import Store.ProductStore exposing (getProduct)
import String exposing (contains, toLower, trim)


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


isSearchProduct : String -> Product -> Bool
isSearchProduct productSearchString product =
    let
        searchString =
            toLower productSearchString

        productName =
            toLower product.name
    in
    contains searchString productName


searchProductSelector : Store -> Dict String Product
searchProductSelector store =
    let
        { productSearchString, products } =
            store
    in
    case trim productSearchString of
        "" ->
            products

        _ ->
            Dict.filter (\_ product -> isSearchProduct productSearchString product) products
