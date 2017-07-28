module AppTest exposing (..)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import SelectList exposing (SelectList)
import View.TabList as TabList exposing (Tab, TabState(..))


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


tabs : SelectList Tab
tabs =
    SelectList.fromLists [] (Tab "#1520" Editing) [ Tab "#1521" Waiting ]


main : Html msg
main =
    div
        [ styles
            [ Css.width (px 500)
            , Css.height (px 40)
            ]
        ]
        [ TabList.view tabs
        ]
