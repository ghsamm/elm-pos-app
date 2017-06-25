module View.OrderLineListContainer exposing (view)

import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Selector.OrderLine exposing (orderLinePrice)
import Store.Main exposing (Store)
import Util exposing (formatPrice)
import View.OrderLineList as OrderLineList


getTotal : Store -> Float
getTotal store =
    let
        lineTotals =
            Dict.values <| Dict.map (\str orderLine -> orderLinePrice orderLine.id store) store.orderLines
    in
    List.foldl (+) 0 lineTotals


viewTotal : Store -> Html msg
viewTotal store =
    div [ class "order-line-list__total" ]
        [ text "TOTAL : "
        , text <| formatPrice <| getTotal <| store
        ]


view : Store -> Html msg
view store =
    let
        s =
            Debug.log "getToal store " <| getTotal store
    in
    div []
        [ OrderLineList.view store.orderLines store
        , viewTotal store
        ]
