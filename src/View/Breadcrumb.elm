module View.Breadcrumb exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import SelectList exposing (SelectList)
import View.Colors as Colors


viewSection : Bool -> String -> Html msg
viewSection isSelected name =
    let
        selectedStyles =
            if isSelected then
                [ borderBottom3 (px 2) solid Colors.accentBg
                , fontWeight bold
                ]

            else
                []
    in
    div
        [ css
            (List.append selectedStyles
                [ displayFlex
                , alignItems center
                , justifyContent center
                , flex (int 1)
                ]
            )
        , Attributes.class "breadcrumb__section"
        ]
        [ text name ]


view : SelectList String -> Html msg
view names =
    let
        selected =
            SelectList.selected names
    in
    div
        [ css
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
