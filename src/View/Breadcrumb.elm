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
            [ Css.property "display" "grid"
            , Css.property "grid-area" "breadcrumb"
            , Css.property "grid-auto-flow" "column"
            , Css.property "grid-gap" "10px"
            , Css.property "justify-items" "center"
            , Css.property "align-items" "baseline"
            , margin2 auto (px 60)
            ]
        , Attributes.class "breadcrumb"
        ]
    <|
        List.intersperse divider (sections |> SelectList.toList)
