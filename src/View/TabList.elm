module View.TabList exposing (Tab, TabState(..), view)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import SelectList exposing (SelectList)


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


type TabState
    = Editing
    | Waiting
    | Done


type alias Tab =
    { text : String
    , state : TabState
    }


viewTab : Tab -> Html msg
viewTab tab =
    div
        [ styles
            [ color (hex "636363")
            , backgroundColor (hex "fff")
            , displayFlex
            , alignItems center
            , justifyContent center
            ]
        ]
        [ Html.text tab.text ]


view : SelectList Tab -> Html msg
view tabs =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-columns" "repeat(auto-fill, 140px)"
            , Css.property "grid-column-gap" "2px"
            , backgroundColor (hex "eee")
            , padding (px 2)
            , Css.height (pct 100)
            , Css.property "justify-items" "stretch"
            , Css.property "align-items" "stretch"
            ]
        ]
    <|
        SelectList.toList <|
            SelectList.map viewTab tabs
