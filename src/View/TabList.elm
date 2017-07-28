module View.TabList exposing (Tab, TabState(..), view)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import SelectList exposing (SelectList)
import View.Colors as Colors


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


viewTab : Tab -> Bool -> Html msg
viewTab tab isSelected =
    div
        [ styles
            [ color Colors.mainText
            , backgroundColor Colors.mainBg
            , displayFlex
            , alignItems center
            , justifyContent center
            , if isSelected then
                mixin
                    [ color Colors.secondaryText
                    , backgroundColor Colors.accentBackground
                    ]
              else
                mixin []
            ]
        , Attributes.class "tab"
        ]
        [ Html.text tab.text ]


view : SelectList Tab -> Html msg
view tabs =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-area" "tab-list"
            , Css.property "grid-template-columns" "repeat(auto-fill, 140px)"
            , Css.property "grid-column-gap" "2px"
            , backgroundColor Colors.secondaryBg
            , padding (px 2)
            , paddingBottom zero
            , borderBottom3 (px 2) solid Colors.accentBackground
            , Css.height (pct 100)
            , Css.property "justify-items" "stretch"
            , Css.property "align-items" "stretch"
            ]
        , Attributes.class "tab-list"
        ]
    <|
        SelectList.toList <|
            SelectList.map (\tab -> viewTab tab (SelectList.selected tabs == tab)) tabs
