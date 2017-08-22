module View.MainSidebar exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLineStore as OrderLineStore exposing (OrderLineStoreMsg(..))
import Data.SideBarRoute as SideBarRoute
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)
import Intl exposing (intl)
import Util exposing (styles)
import View.Colors as Colors
import View.CurrentOrder as Order
import View.OrderActionPanel as OrderActionPanel
import View.OrderList as OrderHistory


viewHeader : Html Msg
viewHeader =
    div
        [ Attributes.class "sidebar-header"
        , styles
            [ position relative
            , displayFlex
            , alignItems center
            , justifyContent center
            , backgroundColor Colors.mainBg
            , fontSize (Css.em 1.2)
            , fontWeight bold
            , borderBottom3 (px 1) solid Colors.secondaryBg
            ]
        ]
        [ a
            [ Attributes.class "sidebar-header__more-button"
            , href "#"
            , styles
                [ position absolute
                , top zero
                , bottom zero
                , left zero
                , Css.width (px 50)
                , displayFlex
                , alignItems center
                , justifyContent center
                , borderRight3 (px 1) solid Colors.secondaryBg
                ]
            , onClick <| ToggleMainSideBarRoute
            ]
            [ Html.text "..."
            ]
        , div [] [ Html.text (intl.ticket ++ " #1520") ]
        ]


viewBody : Model -> Html Msg
viewBody model =
    case model.sideBarRoute of
        SideBarRoute.EditCurrentOrder ->
            div
                [ Attributes.class "main-sidebar__body"
                , styles
                    [ Css.property "display" "grid"
                    , Css.property "grid-template-rows" "1fr 220px"
                    , Css.property "grid-row-gap" "10px"
                    ]
                ]
                [ Order.view model
                , OrderActionPanel.view model
                    { onNumpadClick = OrderLineStoreMsg << SetCurrentOrderLineQuantity
                    , onDecrement = OrderLineStoreMsg DecrementCurrentOrderLineQunatity
                    , onIncrement = OrderLineStoreMsg IncrementCurrentOrderLineQunatity
                    , onDelete = OrderLineStoreMsg DeleteCurrentOrderLine
                    }
                ]

        SideBarRoute.ViewHistory subRoute ->
            OrderHistory.view subRoute model


view : Model -> Html Msg
view model =
    div
        [ Attributes.class "main-sidebar"
        , styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "50px 1fr"
            , Css.property "grid-row-gap" "10px"
            , overflowY Css.hidden
            ]
        ]
        [ viewHeader
        , viewBody model
        ]
