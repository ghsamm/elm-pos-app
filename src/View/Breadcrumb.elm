module View.Breadcrumb exposing (..)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import SelectList exposing (SelectList)
import Util exposing (styles)
import View.Colors as Colors


viewSection : Bool -> String -> Html msg
viewSection isSelected name =
    let
        selectedMixin isSelected =
            if isSelected then
                mixin
                    [ borderBottom3 (px 2) solid Colors.accentBg
                    , fontWeight bold
                    ]
            else
                mixin []
    in
    div
        [ styles
            [ selectedMixin isSelected
            , displayFlex
            , alignItems center
            , justifyContent center
            , flex (int 1)
            ]
        , Attributes.class "breadcrumb__section"
        ]
        [ Html.text name ]


view : SelectList String -> Html msg
view names =
    let
        selected =
            SelectList.selected names
    in
    div
        [ styles
            [ Css.property "display" "flex"
            , Css.property "justify-content" "space-evenly"
            , borderBottom3 (px 1) solid Colors.secondaryBg
            ]
        , Attributes.class "breadcrumb"
        ]
        (names
            |> SelectList.toList
            |> List.map (\name -> viewSection (name == selected) name)
        )
