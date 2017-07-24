module View.MainSidebar exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLine as OrderLine
import Dict
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Selector.OrderLine exposing (orderLinePrice)
import Util exposing (formatPrice)
import View.Numpad as Numpad
import View.OrderLineList as OrderLineList


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


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
    div [ Attributes.class "order-lines-total" ]
        [ Html.text "TOTAL : "
        , Html.text <| formatPrice <| getTotal <| store
        ]


view : Model -> Html Msg
view store =
    div
        [ Attributes.class "main-sidebar"
        , styles
            [ Css.property "display" "grid"
            , borderRight3 (px 2) solid (hex "eee")
            , Css.property "grid-template-rows" "1fr 30px 250px"
            , overflowY Css.hidden
            ]
        ]
        [ OrderLineList.view store.orderLines store
        , viewTotal store
        , Numpad.view
        ]
