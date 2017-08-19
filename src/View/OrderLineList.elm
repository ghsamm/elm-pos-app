module View.OrderLineList exposing (view)

import Css exposing (..)
import Data.Msg exposing (Msg)
import Data.OrderLine exposing (OrderLine, OrderLineId, toId)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (styles)
import View.Colors as Colors
import View.OrderLine as OrderLine


view : (OrderLineId -> Msg) -> Maybe OrderLineId -> List OrderLine -> Html Msg
view onClickOrderLine selectedId list =
    let
        isSelected orderLine =
            Just (toId orderLine) == selectedId
    in
    div
        [ styles
            [ overflowY auto
            , backgroundColor Colors.mainBg
            , padding (px 5)
            ]
        , Attributes.class "order-line-list"
        ]
        (list
            |> List.map
                (\orderLine ->
                    OrderLine.view onClickOrderLine
                        (isSelected orderLine)
                        orderLine
                )
        )
