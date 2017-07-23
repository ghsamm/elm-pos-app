module View.Numpad exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


view : Html msg
view =
    div [ class "numpad" ]
        [ div [ class "numpad__number" ] [ text "1" ]
        , div [ class "numpad__number" ] [ text "2" ]
        , div [ class "numpad__number" ] [ text "3" ]
        , div [ class "numpad__number" ] [ text "4" ]
        , div [ class "numpad__number" ] [ text "5" ]
        , div [ class "numpad__number" ] [ text "6" ]
        , div [ class "numpad__number" ] [ text "7" ]
        , div [ class "numpad__number" ] [ text "8" ]
        , div [ class "numpad__number" ] [ text "9" ]
        , div [ class "numpad__number numpad__number--large" ] [ text "0" ]
        , div [ class "numpad__number" ] [ text "." ]
        ]
