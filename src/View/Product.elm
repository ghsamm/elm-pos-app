module View.Product exposing (..)

import Data.Product exposing (Product)
import Html exposing (..)
import Html.Attributes exposing (..)
import Util exposing (formatPrice)


view : Product -> Html msg
view product =
    div [ class "product__content" ]
        [ div [ class "product__price" ]
            [ text <| formatPrice product.price ]
        , div [ class "product__name" ]
            [ text product.name ]
        ]
