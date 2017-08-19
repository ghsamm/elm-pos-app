module View.ProductList exposing (view)

import Css exposing (..)
import Data.Msg exposing (Msg(..))
import Data.Product exposing (Product, stringToProductId)
import Data.Tag exposing (Tag)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (styles)
import View.Product as ProductView exposing (view)


view : (Product -> Msg) -> List ( Product, Maybe Tag ) -> Html Msg
view onClickProduct productList =
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
                onClickProduct
            )
            productList
