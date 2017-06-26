module View.OrderLineList exposing (view)

import Data.Msg exposing (Msg)
import Data.OrderLine exposing (stringToOrderLineId)
import Dict exposing (keys)
import Html exposing (..)
import Html.Attributes exposing (..)
import Data.Model exposing (Model)
import Store.OrderLineStore exposing (OrderLineStore)
import View.OrderLineContainer as OrderLineContainer exposing (view)


view : OrderLineStore -> Model -> Html Msg
view orderLineStore store =
    div [ class "order-line-list__content" ] <|
        List.map
            (\orderLineId -> OrderLineContainer.view orderLineId store)
            (List.map stringToOrderLineId <| keys orderLineStore)
