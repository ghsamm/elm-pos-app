module View.ProductList exposing (view)

import Css exposing (..)
import Data.Msg exposing (Msg(..))
import Data.OrderLineStore exposing (OrderLineStoreMsg(..))
import Data.Product exposing (Product, stringToProductId)
import Data.Tag exposing (Tag)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (styles)
import View.Product as ProductView exposing (view)


view : List ( Product, Maybe Tag ) -> Html Msg
view productList =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-columns" "repeat(auto-fit, 160px)"
            , Css.property "grid-auto-rows" "120px"
            , Css.property "grid-gap" "5px"
            , Css.property "grid-area" "product-list"
            , Css.property "animation-delay" "600ms"
            ]
        , Attributes.class "product-list slide-fade-in-to-left"
        ]
    <|
        List.map
            (ProductView.view
                (\product -> OrderLineStoreMsg (AddProduct product))
            )
            productList
