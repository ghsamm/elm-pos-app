module View.Breadcrumb exposing (..)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import SelectList exposing (SelectList)
import Util exposing (styles)
import View.Colors as Colors


view : SelectList String -> Html msg
view names =
    let
        divider =
            div [ Attributes.class "breadcrumb__divider" ]
                [ Html.text ">" ]

        selected =
            SelectList.selected names

        nameToSection name =
            let
                isSelected =
                    name == selected
            in
            div
                [ styles
                    (if isSelected then
                        [ borderBottom3 (px 2) solid Colors.accentBg
                        , fontWeight bold
                        ]
                     else
                        []
                    )
                , Attributes.class "breadcrumb__section"
                ]
                [ Html.text name ]

        sections =
            SelectList.map nameToSection names
    in
    div
        [ styles
            [ Css.property "display" "flex"
            , Css.property "grid-area" "breadcrumb"
            , Css.property "justify-content" "space-evenly"
            , alignItems center
            , borderBottom3 (px 1) solid Colors.secondaryBg
            , marginLeft (px -10)
            , marginRight (px -10)
            ]
        , Attributes.class "breadcrumb"
        ]
    <|
        List.intersperse divider (sections |> SelectList.toList)
