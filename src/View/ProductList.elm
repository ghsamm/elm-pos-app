module View.ProductList exposing (view)

import Data.Msg exposing (Msg)
import Data.Product exposing (stringToProductId)
import Dict exposing (keys)
import Html exposing (..)
import Html.Attributes exposing (..)
import Store.Main exposing (Store)
import Store.ProductStore exposing (ProductStore)
import View.ProductContainer as ProductContainer exposing (view)


view : ProductStore -> Store -> Html Msg
view productStore store =
    div [ class "product-list__content" ] <|
        List.map
            (\productId -> ProductContainer.view productId store)
            (List.map stringToProductId <| keys productStore)
