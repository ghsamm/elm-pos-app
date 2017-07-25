module View.Breadcrumb exposing (..)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import SelectList exposing (SelectList)


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


view : SelectList String -> Html msg
view names =
    let
        divider =
            div [ Attributes.class "breadcrumb__divider" ]
                [ Html.text ">" ]

        selected =
            SelectList.selected names

        nameToSection name =
            div
                [ classList
                    [ ( "breadcrumb__section", True )
                    , ( "breadcrumb__section--active", name == selected )
                    ]
                ]
                [ Html.text name ]

        sections =
            SelectList.map nameToSection names
    in
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-auto-flow" "column"
            , Css.property "grid-gap" "10px"
            , Css.property "justify-items" "center"
            , margin2 auto (px 60)
            ]
        , Attributes.class "breadcrumb"
        ]
    <|
        List.intersperse divider (sections |> SelectList.toList)
