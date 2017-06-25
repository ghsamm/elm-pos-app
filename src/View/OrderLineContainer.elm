module View.OrderLineContainer exposing (view)

import Data.OrderLine exposing (OrderLine, OrderLineId)
import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Selector.OrderLine exposing (orderLineSelector)
import Store.Main exposing (Store)
import View.OrderLine as View exposing (view)


view : OrderLineId -> Store -> Html msg
view orderLineId store =
    div
        [ classList
            [ ( "order-line__container", True )
            , ( "order-line__container--selected", True )
            ]
        ]
        [ View.view <| orderLineSelector orderLineId store ]
