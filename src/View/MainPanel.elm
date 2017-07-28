module View.MainPanel exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)
import SelectList
import Selector.Product exposing (searchProductSelector)
import View.ProductList as ProductList
import View.TabList as TabList exposing (Tab, TabState(..))


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


viewProductSearch : Html Msg
viewProductSearch =
    div
        [ styles
            [ Css.property "grid-area" "product-search"
            ]
        , Attributes.class "product-search"
        ]
        [ input
            [ type_ "text"
            , placeholder "Search for products"
            , onInput SearchProduct
            ]
            []
        ]


view : Model -> Html Msg
view store =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "50px auto 1fr"
            , Css.property "grid-template-columns" "1fr auto"
            , Css.property
                "grid-template-areas"
                "'tab-list tab-list' '. product-search' 'product-list product-list'"
            , Css.property "grid-gap" "10px"
            , overflow Css.hidden
            , padding (px 10)
            ]
        , Attributes.class "main-panel"
        ]
        [ TabList.view <|
            SelectList.fromLists
                []
                (Tab "#1520" Editing)
                [ Tab "#1521" Waiting, Tab "#1511" Done ]
        , viewProductSearch
        , ProductList.view (searchProductSelector store) store
        ]
