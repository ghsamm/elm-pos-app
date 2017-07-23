module View.OrderLineList exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (Msg)
import Data.OrderLine exposing (stringToOrderLineId)
import Data.OrderLineStore exposing (OrderLineStore)
import Dict exposing (keys)
import Html exposing (..)
import Html.Attributes exposing (..)
import View.OrderLineContainer as OrderLineContainer exposing (view)


view : OrderLineStore -> Model -> Html Msg
view orderLineStore store =
    div [ class "order-line-list" ] <|
        List.map
            (\orderLineId -> OrderLineContainer.view orderLineId store)
            (List.map stringToOrderLineId <| keys orderLineStore)
