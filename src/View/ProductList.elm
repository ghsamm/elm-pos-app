module View.ProductList exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (Msg)
import Data.Product exposing (stringToProductId)
import Data.ProductStore exposing (ProductStore)
import Dict exposing (keys)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import View.ProductContainer as ProductContainer exposing (view)
import View.Utils exposing (styles)


view : ProductStore -> Model -> Html Msg
view productStore model =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-columns" "repeat(auto-fit, 160px)"
            , Css.property "grid-auto-rows" "120px"
            , Css.property "grid-gap" "5px"
            , Css.property "grid-area" "product-list"
            ]
        , Attributes.class "product-list"
        ]
    <|
        List.map
            (\productId -> ProductContainer.view productId model)
            (List.map stringToProductId <| keys productStore)
