module View.OrderLineContainer exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLine exposing (OrderLine, OrderLineId)
import Data.OrderLineStore exposing (OrderLineStoreMsg(..))
import Html exposing (..)
import Selector.OrderLine exposing (orderLineSelector)
import View.OrderLine as View exposing (view)


view : OrderLineId -> Model -> Html Msg
view orderLineId model =
    let
        isSelected : Bool
        isSelected =
            model.orderLineStore.selectedOrderLine
                |> Maybe.map (\anOrderLineId -> anOrderLineId == orderLineId)
                |> Maybe.withDefault False
    in
    View.view (\orderLineId -> OrderLineStoreMsg (SelectOrderLine orderLineId))
        (orderLineSelector orderLineId model)
        isSelected
