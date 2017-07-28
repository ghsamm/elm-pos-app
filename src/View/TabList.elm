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
    Html.text tab.text


view : SelectList Tab -> Html msg
view tabs =
    div
        [ styles
            []
        ]
    <|
        SelectList.toList <|
            SelectList.map viewTab tabs
