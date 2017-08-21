module View.OrderList exposing (..)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (Msg)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import SelectList
import Util exposing (styles)
import View.Breadcrumb as Breadcrumb
import View.Colors as Colors
import View.Order as Order


view : Model -> Html Msg
view model =
    div
        [ Attributes.class "order-list"
        , styles
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
        , div [ styles [ overflowY auto ] ]
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
