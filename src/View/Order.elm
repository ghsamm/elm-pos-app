module View.Order exposing (..)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLine as OrderLine
import Data.OrderLineStore as OrderLineStore exposing (OrderLineStoreMsg(..))
import Dict
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Selector.OrderLine exposing (orderLineListSelector, orderLinePrice)
import Util exposing (formatPrice, styles)
import View.Colors as Colors
import View.OrderLineList as OrderLineList


viewHeader : Html Msg
viewHeader =
    div
        [ Attributes.class "order-header"
        , styles
            [ displayFlex
            , alignItems center
            , justifyContent center
            , backgroundColor Colors.mainBg
            , fontSize (Css.em 1.2)
            , fontWeight bold
            , borderBottom3 (px 1) solid Colors.secondaryBg
            ]
        ]
        [ Html.text "TICKET #1520" ]


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
        [ Attributes.class "order-total"
        , styles
            [ displayFlex
            , alignItems center
            , justifyContent spaceBetween
            , fontSize (Css.em 1.2)
            , textAlign right
            , padding2 (px 5) (px 10)
            , backgroundColor Colors.mainBg
            , fontWeight bold
            , borderTop3 (px 1) solid Colors.secondaryBg
            ]
        ]
        [ div [] [ Html.text "TOTAL " ]
        , div [] [ Html.text <| formatPrice <| getTotal <| model ]
        ]


view : Model -> Html Msg
view model =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "50px 1fr 40px"
            , overflowY Css.hidden
            ]
        , Attributes.class "order"
        ]
        [ viewHeader
        , OrderLineList.view
            (\orderLineId -> OrderLineStoreMsg (SelectOrderLine orderLineId))
            model.orderLineStore.selectedOrderLine
            (model.orderLineStore.orderLines
                |> Dict.toList
                |> List.map Tuple.second
            )
        , viewTotal model
        ]
