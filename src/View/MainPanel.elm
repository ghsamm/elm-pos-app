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
import View.TagList as TagList exposing (Tag)
import View.Utils exposing (styles)


viewProductSearch : Html Msg
viewProductSearch =
    div
        [ styles
            [ Css.property "grid-area" "product-search"
            , displayFlex
            ]
        , Attributes.class "product-search"
        ]
        [ input
            [ styles
                [ border zero
                , padding (px 10)
                ]
            , type_ "text"
            , placeholder "Search for products"
            , onInput SearchProduct
            ]
            []
        ]


view : Model -> Html Msg
view model =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "50px 50px 1fr"
            , Css.property "grid-template-columns" "auto 1fr"
            , Css.property
                "grid-template-areas"
                "'tab-list tab-list' 'product-search tag-list' 'product-list product-list'"
            , Css.property "grid-gap" "10px"
            , overflow Css.hidden
            , padding (px 5)
            ]
        , Attributes.class "main-panel"
        ]
        [ TabList.view <|
            SelectList.fromLists
                []
                (Tab "#1520" Editing)
                [ Tab "#1521" Waiting, Tab "#1511" Done ]
        , viewProductSearch
        , TagList.view
            [ Tag "Pizza" (hex "faa")
            , Tag "Déjeuner" (hex "aaf")
            ]
        , ProductList.view (searchProductSelector model) model
        ]
