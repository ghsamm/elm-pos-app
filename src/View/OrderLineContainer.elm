module View.OrderLineContainer exposing (view)

import Data.Model exposing (Model, Selection(..))
import Data.Msg exposing (..)
import Data.OrderLine exposing (OrderLine, OrderLineId)
import Html exposing (..)
import Html.Attributes exposing (class, classList)
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
