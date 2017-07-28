module View.TabList exposing (Tab, TabState(..), view)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import SelectList exposing (SelectList)


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


colors :
    { mainBg : Color
    , mainText : Color
    , secondaryBg : Color
    , secondaryText : Color
    , accentBackground : Color
    }
colors =
    { mainText = hex "636363"
    , secondaryText = hex "fff"
    , mainBg = hex "fff"
    , secondaryBg = hex "eee"
    , accentBackground = hex "0086AF"
    }


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
            [ color colors.mainText
            , backgroundColor colors.mainBg
            , displayFlex
            , alignItems center
            , justifyContent center
            , if isSelected then
                mixin
                    [ color colors.secondaryText
                    , backgroundColor colors.accentBackground
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
            , backgroundColor colors.secondaryBg
            , padding (px 2)
            , paddingBottom zero
            , borderBottom3 (px 2) solid colors.accentBackground
            , Css.height (pct 100)
            , Css.property "justify-items" "stretch"
            , Css.property "align-items" "stretch"
            ]
        , Attributes.class "tab-list"
        ]
    <|
        SelectList.toList <|
            SelectList.map (\tab -> viewTab tab (SelectList.selected tabs == tab)) tabs
