module View.MainSidebar exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLine as OrderLine
import Data.OrderLineStore exposing (OrderLineStoreMsg(..))
import Dict
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Selector.OrderLine exposing (orderLinePrice)
import Util exposing (formatPrice, styles)
import View.Colors as Colors
import View.OrderActionPanel as OrderActionPanel
import View.OrderLineList as OrderLineList


getTotal : Model -> Float
getTotal model =
    let
        lineTotals =
            Dict.values <|
                Dict.map
                    (\str orderLine ->
                        orderLinePrice (orderLine |> OrderLine.toId) model
                    )
                    model.orderLineStore.orderLines
    in
    List.foldl (+) 0 lineTotals


viewTotal : Model -> Html Msg
viewTotal model =
    div
        [ Attributes.class "order-lines-total slide-fade-in-to-right"
        , styles
            [ displayFlex
            , alignItems center
            , justifyContent spaceBetween
            , fontSize (Css.em 1.2)
            , textAlign right
            , padding2 (px 5) (px 10)
            , backgroundColor Colors.mainBg
            , fontWeight bold
            , Css.property "animation-delay" "100ms"
            ]
        ]
        [ div [] [ Html.text "TOTAL " ]
        , div [] [ Html.text <| formatPrice <| getTotal <| model ]
        ]


view : Model -> Html Msg
view model =
    div
        [ Attributes.class "main-sidebar"
        , styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "1fr 40px auto"
            , Css.property "grid-row-gap" "10px"
            , overflowY Css.hidden
            ]
        ]
        [ OrderLineList.view model.orderLineStore model
        , viewTotal model
        , OrderActionPanel.view model
            { onNumpadClick = \newQuantity -> OrderLineStoreMsg (SetCurrentOrderLineQuantity newQuantity)
            , onDecrement = OrderLineStoreMsg DecrementCurrentOrderLineQunatity
            , onIncrement = OrderLineStoreMsg IncrementCurrentOrderLineQunatity
            , onDelete = OrderLineStoreMsg DeleteCurrentOrderLine
            }
        ]
