module View.Numpad exposing (view)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


view : Html msg
view =
    let
        renderNumber number =
            div
                [ styles
                    [ if number == "0" then
                        Css.property "grid-column-end" "span 2"
                      else
                        Css.property "grid-column-end" "initial"
                    , Css.property "display" "grid"
                    , Css.property "justify-content" "center"
                    , Css.property "align-content" "center"
                    , backgroundColor (hex "BBB")
                    ]
                , Attributes.class "numpad__number"
                ]
                [ Html.text number ]
    in
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-columns" "repeat(3, 50px)"
            , Css.property "grid-template-rows" "repeat(4, 50px)"
            , Css.property "grid-gap" "2px"
            , borderRadius (px 5)
            , color (hex "fff")
            , alignItems stretch
            , Css.property "justify-items" "stretch"
            , Css.property "justify-self" "center"
            , Css.property "align-self" "center"
            , overflow Css.hidden
            ]
        , Attributes.class "numpad"
        ]
        [ renderNumber "1"
        , renderNumber "2"
        , renderNumber "3"
        , renderNumber "4"
        , renderNumber "5"
        , renderNumber "6"
        , renderNumber "7"
        , renderNumber "8"
        , renderNumber "9"
        , renderNumber "0"
        , renderNumber "."
        ]
