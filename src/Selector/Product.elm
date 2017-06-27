module Selector.Product exposing (..)

import Data.Model exposing (Model)
import Data.Product as Product exposing (Product, ProductErr(..), ProductId)
import Data.ProductStore exposing (getProduct)
import Dict exposing (Dict)
import String exposing (contains, toLower, trim)


productSelector : ProductId -> Model -> Result ProductErr Product
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
            product |> Product.toName |> toLower
    in
    contains searchString productName


searchProductSelector : Model -> Dict String Product
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
