module View.MainPanel exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)
import SelectList
import Selector.Product exposing (searchProductSelector)
import View.Breadcrumb as Breadcrumb
import View.ProductList as ProductList


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


viewProductSearch : Html Msg
viewProductSearch =
    div [ Attributes.class "product-search" ]
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
            , Css.property "grid-template-rows" "auto 1fr"
            , Css.property "grid-template-columns" "1fr auto"
            , Css.property "grid-gap" "10px"
            , overflow Css.hidden
            , padding (px 10)
            ]
        , Attributes.class "main-panel"
        ]
        [ Breadcrumb.view (SelectList.singleton "fsdfsd fs df")
        , viewProductSearch
        , ProductList.view (searchProductSelector store) store
        ]
