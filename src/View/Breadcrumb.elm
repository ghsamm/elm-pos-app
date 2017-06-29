module View.Breadcrumb exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import SelectList exposing (SelectList)


view : SelectList String -> Html msg
view names =
    let
        divider =
            div [ class "breadcrumb__divider" ]
                [ text ">" ]

        selected =
            SelectList.selected names

        nameToSection name =
            div
                [ classList
                    [ ( "breadcrumb__section", True )
                    , ( "breadcrumb__section--active", name == selected )
                    ]
                ]
                [ text name ]

        sections =
            SelectList.map nameToSection names
    in
    div [ class "breadcrumb__content" ] <|
        List.intersperse divider (sections |> SelectList.toList)
