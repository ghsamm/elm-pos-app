module View.Order exposing (..)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (styles)
import View.Colors as Colors


view : Html msg
view =
    div
        [ Attributes.class "order"
        , styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "auto auto"
            , Css.property "grid-template-columns" "1fr auto"
            , Css.property "grid-template-areas" "'title time' 'content content'"
            , Css.property "align-items" "baseline"
            , padding (px 5)
            , marginBottom (px 5)
            , borderBottom3 (px 1) solid Colors.secondaryBg
            ]
        ]
        [ div
            [ Attributes.class "order-title"
            , styles
                [ Css.property "grid-area" "title"
                , fontWeight bold
                , fontWeight bold
                ]
            ]
            [ Html.text "TICKET #1519" ]
        , div
            [ Attributes.class "order-time"
            , styles
                [ Css.property "grid-area" "time"
                , fontSize (Css.em 0.9)
                ]
            ]
            [ Html.text "2 min. ago" ]
        , div
            [ Attributes.class "order-content"
            , styles
                [ Css.property "grid-area" "content"
                , padding (px 5)
                , paddingLeft (px 20)
                ]
            ]
            [ div [] [ Html.text "2 x Pizza 4 Saisons" ]
            , div [] [ Html.text "1 x Pizza Thon" ]
            , div [] [ Html.text "3 x Petit Déj Le Prince" ]
            ]
        ]
