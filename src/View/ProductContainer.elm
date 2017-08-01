module View.ProductContainer exposing (..)

import Data.Model exposing (Model)
import Data.Msg exposing (Msg(AddProductToLineOrderList))
import Data.Product exposing (Product, ProductId, productIdToString)
import Html exposing (..)
import Selector.Product exposing (productSelector)
import View.Product as ProductView


view : ProductId -> Model -> Html Msg
view productId model =
    let
        product =
            productSelector productId model
    in
    ProductView.view AddProductToLineOrderList product
