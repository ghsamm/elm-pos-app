module View.OrderLine exposing (view)

import Data.OrderLine exposing (OrderLine)
import Data.Product exposing (Product)
import Html exposing (..)


view : ( OrderLine, Product ) -> Html msg
view ( orderLine, product ) =
    div [] [ text <| "product " ++ product.name ]
