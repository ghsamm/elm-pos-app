module View.Numpad exposing (view)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import View.Colors as Colors
import View.Utils exposing (styles)


view : Html msg
view =
    let
        renderNumber number =
            div
                [ styles
                    [ Css.property "display" "grid"
                    , Css.property "justify-content" "center"
                    , Css.property "align-content" "center"
                    , fontWeight bold
                    , backgroundColor Colors.secondaryBg
                    ]
                , Attributes.class "numpad__number"
                ]
                [ Html.text number ]
    in
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-area" "action-left"
            , Css.property "grid-template-columns" "repeat(3, 50px)"
            , Css.property "grid-template-rows" "repeat(3, 50px)"
            , Css.property "grid-gap" "2px"
            , borderRadius (px 5)
            , alignItems stretch
            , Css.property "justify-items" "stretch"
            , Css.property "justify-self" "center"
            , Css.property "align-self" "center"
            , overflow Css.hidden
            , backgroundColor Colors.secondaryText
            , border3 (px 2) solid Colors.secondaryText
            ]
        , Attributes.class "numpad"
        ]
        (List.range 1 9
            |> List.map toString
            |> List.map renderNumber
        )
