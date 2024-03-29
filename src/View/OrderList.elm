module View.OrderList exposing (..)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (Msg)
import Data.SideBarRoute as SideBarRoute
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import SelectList
import View.Breadcrumb as Breadcrumb
import View.Colors as Colors
import View.Order as Order


view : SideBarRoute.ViewHistorySubRoute -> Model -> Html Msg
view subRoute model =
    div
        [ Attributes.class "order-list"
        , css
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "40px 1fr"
            , Css.property "grid-gap" "10px"
            , backgroundColor Colors.mainBg
            , padding (px 5)
            , overflowY auto
            ]
        ]
        [ Breadcrumb.view <|
            SelectList.fromLists []
                "Current Orders"
                [ "Today's History" ]
        , div [ css [ overflowY auto ] ]
            [ Order.view
            , Order.view
            , Order.view
            , Order.view
            , Order.view
            , Order.view
            , Order.view
            , Order.view
            ]
        ]
