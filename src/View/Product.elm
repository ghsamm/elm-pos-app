module View.Product exposing (..)

import Data.Product exposing (Product, ProductErr)
import Html exposing (..)
import Html.Attributes exposing (..)
import Util exposing (formatPrice)


view : Result ProductErr Product -> Html msg
view product =
    case product of
        Err _ ->
            text "this product is unavailable"

        Ok product ->
            div [ class "product__content" ]
                [ div [ class "product__price" ]
                    [ text <| formatPrice product.price ]
                , div [ class "product__name" ]
                    [ text product.name ]
                ]
