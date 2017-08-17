module View.OrderLineListContainer exposing (..)

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
            , Css.property "grid-template-rows" "1fr 40px"
            , overflowY Css.hidden
            ]
        , Attributes.class "order-line-list-container"
        ]
        [ OrderLineList.view
            (\orderLineId -> OrderLineStoreMsg (SelectOrderLine orderLineId))
            model.orderLineStore.selectedOrderLine
            (OrderLineStore.orderLineIdList model.orderLineStore
                |> (\idList -> orderLineListSelector idList model)
            )
        , viewTotal model
        ]