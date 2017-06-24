module View.OrderLineContainer exposing (view)

import Data.OrderLine exposing (OrderLine, OrderLineId)
import Html exposing (Html)
import Selector.OrderLine exposing (orderLineSelector)
import Store.Main exposing (Store)
import View.OrderLine as View exposing (view)


view : OrderLineId -> Store -> Html msg
view orderLineId store =
    View.view <| orderLineSelector orderLineId store
