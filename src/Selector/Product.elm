module Selector.Product exposing (..)

import Data.Model exposing (Model)
import Data.Product exposing (Product, ProductErr(..), ProductId)
import Data.ProductStore exposing (getProduct)


productSelector : ProductId -> Model -> Result ProductErr Product
productSelector productId model =
    let
        maybeProduct =
            getProduct productId model.productStore
    in
    case maybeProduct of
        Nothing ->
            Err ProductNotFound

        Just product ->
            Ok product



-- isSearchProduct : String -> Product -> Bool
-- isSearchProduct productSearchString product =
--     let
--         searchString =
--             toLower productSearchString
--
--         productName =
--             product |> Product.toName |> toLower
--     in
--     contains searchString productName
--
--
-- searchProductSelector : Model -> ProductStore
-- searchProductSelector model =
--     let
--         { productSearchString, productStore } =
--             model
--     in
--     case trim productSearchString of
--         "" ->
--             productStore
--
--         _ ->
--             { productStore | products = Dict.filter (\_ product -> isSearchProduct productSearchString product) productStore.products }
