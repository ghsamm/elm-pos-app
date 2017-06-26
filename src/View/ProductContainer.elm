module View.ProductContainer exposing (..)

import Data.Msg exposing (..)
import Data.Product exposing (Product, ProductId, productIdToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Selector.Product exposing (productSelector)
import Data.Model exposing (Model)
import View.Product as ProductView


view : ProductId -> Model -> Html Msg
view productId store =
    let
        product =
            productSelector productId store
    in
    div [ class "product__container" ]
        [ ProductView.view AddProductToLineOrderList product ]



-- [ ProductView.view product ]
