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
import View.Colors as Colors
import View.OrderActionPanel as OrderActionPanel
import View.OrderLineList as OrderLineList
import View.Utils exposing (styles)


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
    div
        [ Attributes.class "order-lines-total"
        , styles
            [ displayFlex
            , alignItems center
            , justifyContent spaceBetween
            , fontSize (Css.em 1.2)
            , textAlign right
            , padding2 (px 5) (px 10)
            , backgroundColor Colors.mainBg
            , fontWeight bold
            ]
        ]
        [ div [] [ Html.text "TOTAL " ]
        , div [] [ Html.text <| formatPrice <| getTotal <| store ]
        ]


view : Model -> Html Msg
view store =
    div
        [ Attributes.class "main-sidebar"
        , styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "1fr 40px auto"
            , Css.property "grid-row-gap" "5px"
            , overflowY Css.hidden
            ]
        ]
        [ OrderLineList.view store.orderLines store
        , viewTotal store
        , OrderActionPanel.view store SetCurrentOrderLineQuantity
        ]
