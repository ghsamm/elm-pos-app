module View.OrderLineListContainer exposing (view)

import Data.Msg exposing (..)
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Selector.OrderLine exposing (orderLinePrice)
import Store.Main exposing (Model)
import Util exposing (formatPrice)
import View.OrderLineList as OrderLineList


getTotal : Model -> Float
getTotal store =
    let
        lineTotals =
            Dict.values <| Dict.map (\str orderLine -> orderLinePrice orderLine.id store) store.orderLines
    in
    List.foldl (+) 0 lineTotals


viewTotal : Model -> Html Msg
viewTotal store =
    div [ class "order-line-list__total" ]
        [ text "TOTAL : "
        , text <| formatPrice <| getTotal <| store
        ]


view : Model -> Html Msg
view store =
    div [ class "order-line-list__container" ]
        [ OrderLineList.view store.orderLines store
        , viewTotal store
        ]
