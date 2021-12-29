module View.MainSidebar exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLineStore as OrderLineStore exposing (OrderLineStoreMsg(..))
import Data.SideBarRoute as SideBarRoute
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Intl exposing (intl)
import View.Colors as Colors
import View.CurrentOrder as Order
import View.OrderActionPanel as OrderActionPanel
import View.OrderList as OrderHistory


viewHeader : Html Msg
viewHeader =
    div
        [ Attributes.class "sidebar-header"
        , css
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
            , css
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
            [ text "..."
            ]
        , div [] [ text (intl.ticket ++ " #1520") ]
        ]


viewBody : Model -> Html Msg
viewBody model =
    case model.sideBarRoute of
        SideBarRoute.EditCurrentOrder ->
            div
                [ Attributes.class "main-sidebar__body"
                , css
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
        , css
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "50px 1fr"
            , Css.property "grid-row-gap" "10px"
            , overflowY Css.hidden
            ]
        ]
        [ viewHeader
        , viewBody model
        ]
