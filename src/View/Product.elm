module View.Product exposing (..)

import Data.Product exposing (Product, ProductErr, ProductId)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Util exposing (formatPrice)


view : (ProductId -> msg) -> Result ProductErr Product -> Html msg
view handleClick product =
    case product of
        Err _ ->
            text "this product is unavailable"

        Ok product ->
            div
                [ class "product__content"
                , onClick (handleClick product.id)
                ]
                [ div [ class "product__price" ]
                    [ text <| formatPrice product.price ]
                , div [ class "product__name" ]
                    [ text product.name ]
                ]
