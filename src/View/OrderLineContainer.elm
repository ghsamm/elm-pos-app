module View.OrderLineContainer exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLine exposing (OrderLine, OrderLineId)
import Data.Selection exposing (Selection(..))
import Html exposing (..)
import Selector.OrderLine exposing (orderLineSelector)
import View.OrderLine as View exposing (view)


view : OrderLineId -> Model -> Html Msg
view orderLineId store =
    let
        isSelected =
            case store.selectedOrderLine of
                NoSelection ->
                    False

                SingleSelection id ->
                    id == orderLineId
    in
    View.view SelectOrderLine
        (orderLineSelector orderLineId store)
        isSelected
