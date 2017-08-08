module View.OrderLineList exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (Msg)
import Data.OrderLine exposing (stringToOrderLineId)
import Data.OrderLineStore exposing (OrderLineStore)
import Dict exposing (keys)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (styles)
import View.Colors as Colors
import View.OrderLineContainer as OrderLineContainer


view : OrderLineStore -> Model -> Html Msg
view orderLineStore model =
    div
        [ styles
            [ overflowY auto
            , backgroundColor Colors.mainBg
            , padding (px 5)
            ]
        , Attributes.class "order-line-list"
        ]
    <|
        List.map
            (\orderLineId -> OrderLineContainer.view orderLineId model)
            (List.map stringToOrderLineId <| keys orderLineStore.orderLines)
