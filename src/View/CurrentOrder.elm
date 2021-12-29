module View.CurrentOrder exposing (..)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLine as OrderLine
import Data.OrderLineStore exposing (OrderLineStoreMsg(..))
import Dict
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import Intl exposing (intl)
import Util exposing (formatPrice)
import View.Colors as Colors
import View.OrderLineList as OrderLineList


getTotal : Model -> Float
getTotal model =
    model.orderLineStore.orderLines
        |> Dict.toList
        |> List.map Tuple.second
        |> List.map OrderLine.toPrice
        |> List.foldl (+) 0


viewTotal : Model -> Html Msg
viewTotal model =
    div
        [ Attributes.class "order-total"
        , css
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
        [ div [] [ text "intl.total" ]
        , div [] [ text <| formatPrice <| getTotal <| model ]
        ]


view : Model -> Html Msg
view model =
    div
        [ css
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "1fr 40px"
            , overflowY Css.hidden
            ]
        , Attributes.class "current-order"
        ]
        [ OrderLineList.view
            (\orderLineId -> OrderLineStoreMsg (SelectOrderLine orderLineId))
            model.orderLineStore.selectedOrderLine
            (model.orderLineStore.orderLines
                |> Dict.toList
                |> List.map Tuple.second
            )
        , viewTotal model
        ]
