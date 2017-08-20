module View.MainSidebar exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLineStore as OrderLineStore exposing (OrderLineStoreMsg(..))
import Data.SideBarRoute exposing (SideBarRoute(..))
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (styles)
import View.Order as Order
import View.OrderActionPanel as OrderActionPanel
import View.OrderHistory as OrderHistory


viewWhenEditingOrder : Model -> Html Msg
viewWhenEditingOrder model =
    div
        [ Attributes.class "main-sidebar"
        , styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "1fr 220px"
            , Css.property "grid-row-gap" "10px"
            , overflowY Css.hidden
            ]
        ]
        [ Order.view (SetMainSideBarRoute ViewingHistory) model
        , OrderActionPanel.view model
            { onNumpadClick = OrderLineStoreMsg << SetCurrentOrderLineQuantity
            , onDecrement = OrderLineStoreMsg DecrementCurrentOrderLineQunatity
            , onIncrement = OrderLineStoreMsg IncrementCurrentOrderLineQunatity
            , onDelete = OrderLineStoreMsg DeleteCurrentOrderLine
            }
        ]


viewWhenViewingHistory : Model -> Html Msg
viewWhenViewingHistory model =
    div
        [ Attributes.class "main-sidebar"
        , styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "1fr"
            , Css.property "grid-row-gap" "10px"
            , overflowY Css.hidden
            ]
        ]
        [ OrderHistory.view model ]


view : Model -> Html Msg
view model =
    case model.sideBarRoute of
        EditingOrder ->
            viewWhenEditingOrder model

        ViewingHistory ->
            viewWhenViewingHistory model
