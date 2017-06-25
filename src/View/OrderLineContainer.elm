module View.OrderLineContainer exposing (view)

import Data.OrderLine exposing (OrderLine, OrderLineId)
import Html exposing (..)
import Html.Attributes exposing (class)
import Selector.OrderLine exposing (orderLineSelector)
import Store.Main exposing (Store)
import View.OrderLine as View exposing (view)


view : OrderLineId -> Store -> Html msg
view orderLineId store =
    div [ class "order-line__container" ] [ View.view <| orderLineSelector orderLineId store ]
