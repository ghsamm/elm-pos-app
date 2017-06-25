module View.ProductContainer exposing (..)

import Data.Product exposing (Product, ProductId, productIdToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Selector.Product exposing (productSelector)
import Store.Main exposing (Store)
import View.Product as ProductView


view : ProductId -> Store -> Html msg
view productId store =
    let
        product =
            productSelector productId store
    in
    div [ class "product__container" ]
        [ ProductView.view product ]



-- [ ProductView.view product ]
