module View.OrderLine exposing (view)

import Data.OrderLine exposing (OrderLine, OrderLineErr)
import Data.Product exposing (Product)
import Html exposing (..)


view : Result OrderLineErr ( OrderLine, Product ) -> Html msg
view viewData =
    case viewData of
        Err _ ->
            div [] [ text "this line is invalid" ]

        Ok ( orderLine, product ) ->
            div [] [ text <| "product " ++ product.name ]
