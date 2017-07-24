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


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


view : ProductStore -> Model -> Html Msg
view productStore store =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-columns" "repeat(auto-fit, 120px)"
            , Css.property "grid-auto-rows" "120px"
            , Css.property "grid-gap" "5px 10px"
            , Css.property "grid-column-end" "span 2"
            ]
        , Attributes.class "product-list"
        ]
    <|
        List.map
            (\productId -> ProductContainer.view productId store)
            (List.map stringToProductId <| keys productStore)
