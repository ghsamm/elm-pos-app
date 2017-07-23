module View.ProductList exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (Msg)
import Data.Product exposing (stringToProductId)
import Data.ProductStore exposing (ProductStore)
import Dict exposing (keys)
import Html exposing (..)
import Html.Attributes exposing (..)
import View.ProductContainer as ProductContainer exposing (view)


view : ProductStore -> Model -> Html Msg
view productStore store =
    div [ class "product-list" ] <|
        List.map
            (\productId -> ProductContainer.view productId store)
            (List.map stringToProductId <| keys productStore)
