module View.ProductListContainer exposing (view)

import Data.Msg exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Selector.Product exposing (searchProductSelector)
import Store.Main exposing (Store)
import View.ProductList as ProductList


viewProductListSearch : Html Msg
viewProductListSearch =
    div [ class "product-list__search-container" ]
        [ input
            [ type_ "text"
            , placeholder "Search for products"
            , onInput SearchProduct
            ]
            []
        ]


view : Store -> Html Msg
view store =
    div [ class "product-list__container" ]
        [ viewProductListSearch
        , ProductList.view (searchProductSelector store) store
        ]
