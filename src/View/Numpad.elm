module View.Numpad exposing (view)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import Html.Styled.Events exposing (..)
import View.Colors as Colors


renderNumber : Bool -> Int -> msg -> Html msg
renderNumber isSelected number handleClick =
    let
        selectedStyle =
            if isSelected then
                [ color Colors.secondaryText
                , backgroundColor Colors.accentBg
                ]

            else
                []
    in
    a
        [ css
            (List.append selectedStyle
                [ Css.property "display" "grid"
                , Css.property "justify-content" "center"
                , Css.property "align-content" "center"
                , fontWeight bold
                , backgroundColor Colors.secondaryBg
                ]
            )
        , href "#"
        , onClick handleClick
        , Attributes.class "numpad__number"
        ]
        [ text <| String.fromInt number ]


view : Maybe Int -> (Int -> msg) -> Html msg
view selectedNumber handleClick =
    div
        [ css
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
