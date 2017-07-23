module View.MainSidebar exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLine as OrderLine
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Selector.OrderLine exposing (orderLinePrice)
import Util exposing (formatPrice)
import View.OrderLineList as OrderLineList


getTotal : Model -> Float
getTotal store =
    let
        lineTotals =
            Dict.values <|
                Dict.map
                    (\str orderLine ->
                        orderLinePrice (orderLine |> OrderLine.toId) store
                    )
                    store.orderLines
    in
    List.foldl (+) 0 lineTotals


viewTotal : Model -> Html Msg
viewTotal store =
    div [ class "order-lines-total" ]
        [ text "TOTAL : "
        , text <| formatPrice <| getTotal <| store
        ]


view : Model -> Html Msg
view store =
    div [ class "main-sidebar" ]
        [ OrderLineList.view store.orderLines store
        , viewTotal store
        ]
