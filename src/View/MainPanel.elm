module View.MainPanel exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Selector.Product exposing (searchProductSelector)
import View.ProductList as ProductList


viewProductListSearch : Html Msg
viewProductListSearch =
    div [ class "product-search" ]
        [ input
            [ type_ "text"
            , placeholder "Search for products"
            , onInput SearchProduct
            ]
            []
        ]


view : Model -> Html Msg
view store =
    div [ class "main-panel" ]
        [ viewProductListSearch
        , ProductList.view (searchProductSelector store) store
        ]
