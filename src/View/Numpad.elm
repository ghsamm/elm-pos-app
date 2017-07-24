module View.Numpad exposing (view)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


view : Html msg
view =
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
        [ div [ Attributes.class "numpad__number" ] [ Html.text "1" ]
        , div [ Attributes.class "numpad__number" ] [ Html.text "2" ]
        , div [ Attributes.class "numpad__number" ] [ Html.text "3" ]
        , div [ Attributes.class "numpad__number" ] [ Html.text "4" ]
        , div [ Attributes.class "numpad__number" ] [ Html.text "5" ]
        , div [ Attributes.class "numpad__number" ] [ Html.text "6" ]
        , div [ Attributes.class "numpad__number" ] [ Html.text "7" ]
        , div [ Attributes.class "numpad__number" ] [ Html.text "8" ]
        , div [ Attributes.class "numpad__number" ] [ Html.text "9" ]
        , div [ Attributes.class "numpad__number numpad__number--large" ] [ Html.text "0" ]
        , div [ Attributes.class "numpad__number" ] [ Html.text "." ]
        ]
