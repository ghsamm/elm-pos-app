module View.OrderLineList exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (Msg)
import Data.OrderLine exposing (stringToOrderLineId)
import Data.OrderLineStore exposing (OrderLineStore)
import Dict exposing (keys)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import View.Colors as Colors
import View.OrderLineContainer as OrderLineContainer exposing (view)


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


view : OrderLineStore -> Model -> Html Msg
view orderLineStore store =
    div
        [ styles
            [ overflowY auto
            , backgroundColor Colors.mainBg
            ]
        , Attributes.class "order-line-list"
        ]
    <|
        List.map
            (\orderLineId -> OrderLineContainer.view orderLineId store)
            (List.map stringToOrderLineId <| keys orderLineStore)
