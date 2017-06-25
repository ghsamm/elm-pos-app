module View.OrderLineList exposing (view)

import Data.OrderLine exposing (stringToOrderLineId)
import Dict exposing (keys)
import Html exposing (..)
import Html.Attributes exposing (..)
import Store.Main exposing (Store)
import Store.OrderLineStore exposing (OrderLineStore)
import View.OrderLineContainer as OrderLineContainer exposing (view)


view : OrderLineStore -> Store -> Html msg
view orderLineStore store =
    div [ class "order-line-list__container" ] <|
        List.map
            (\orderLineId -> OrderLineContainer.view orderLineId store)
            (List.map stringToOrderLineId <| keys orderLineStore)