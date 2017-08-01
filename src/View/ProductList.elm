module View.ProductList exposing (view)

import Css exposing (..)
import Data.Msg exposing (Msg(AddProductToLineOrderList))
import Data.Product exposing (Product, stringToProductId)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import View.Product as ProductView exposing (view)
import View.Utils exposing (styles)


view : List Product -> Html Msg
view productList =
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
            (ProductView.view
                AddProductToLineOrderList
            )
            productList
