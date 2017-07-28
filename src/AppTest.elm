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
    SelectList.fromLists [] (Tab "#1520" Waiting) []


main : Html msg
main =
    div [ styles [] ]
        [ TabList.view tabs
        ]
