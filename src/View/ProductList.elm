module View.ProductList exposing (view)

import Css exposing (..)
import Data.Msg exposing (Msg(..))
import Data.Product exposing (Product)
import Data.Tag exposing (Tag)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import View.Product as ProductView


view : (Product -> Msg) -> List ( Product, Maybe Tag ) -> Html Msg
view onClickProduct productList =
    div
        [ css
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
