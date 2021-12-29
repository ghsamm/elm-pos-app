module View.Order exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import View.Colors as Colors


view : Html msg
view =
    div
        [ Attributes.class "order"
        , css
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
            , css
                [ Css.property "grid-area" "title"
                , fontWeight bold
                , fontWeight bold
                ]
            ]
            [ text "TICKET #1519" ]
        , div
            [ Attributes.class "order-time"
            , css
                [ Css.property "grid-area" "time"
                , fontSize (Css.em 0.9)
                ]
            ]
            [ text "2 min. ago" ]
        , div
            [ Attributes.class "order-content"
            , css
                [ Css.property "grid-area" "content"
                , padding (px 5)
                , paddingLeft (px 20)
                ]
            ]
            [ div [] [ text "2 x Pizza 4 Saisons" ]
            , div [] [ text "1 x Pizza Thon" ]
            , div [] [ text "3 x Petit Déj Le Prince" ]
            ]
        ]
