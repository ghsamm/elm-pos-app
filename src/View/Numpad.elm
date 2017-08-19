module View.Numpad exposing (view)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)
import Util exposing (styles)
import View.Colors as Colors


renderNumber : Bool -> Int -> msg -> Html msg
renderNumber isSelected number handleClick =
    a
        [ styles
            [ Css.property "display" "grid"
            , Css.property "justify-content" "center"
            , Css.property "align-content" "center"
            , fontWeight bold
            , backgroundColor Colors.secondaryBg
            , if isSelected then
                mixin
                    [ color Colors.secondaryText
                    , backgroundColor Colors.accentBg
                    ]
              else
                mixin []
            ]
        , href "#"
        , onClick handleClick
        , Attributes.class "numpad__number"
        ]
        [ Html.text <| toString number ]


view : Maybe Int -> (Int -> msg) -> Html msg
view selectedNumber handleClick =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-area" "action-left"
            , Css.property "grid-template-columns" "repeat(3, 1fr)"
            , Css.property "grid-template-rows" "repeat(3, 1fr)"
            , Css.property "grid-gap" "2px"
            , backgroundColor Colors.secondaryText
            ]
        , Attributes.class "numpad"
        ]
        (List.range 1 9
            |> List.map (\number -> renderNumber (Just number == selectedNumber) number (handleClick number))
        )
