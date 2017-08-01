module Selector.Product exposing (..)

import Data.Model exposing (Model)
import Data.Product as Product exposing (Product, ProductErr(..), ProductId)
import Data.ProductStore exposing (getProduct)
import Dict exposing (Dict)
import String exposing (contains, toLower, trim)


productSelector : ProductId -> Model -> Result ProductErr Product
productSelector productId model =
    let
        product =
            getProduct productId model.productStore
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
searchProductSelector model =
    let
        { productSearchString, productStore } =
            model
    in
    case trim productSearchString of
        "" ->
            productStore

        _ ->
            Dict.filter (\_ product -> isSearchProduct productSearchString product) productStore
