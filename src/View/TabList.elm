module View.TabList exposing (Tab, TabState(..), view)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import SelectList exposing (SelectList)
import View.Colors as Colors


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
    let
        selectedStyles =
            if isSelected then
                [ color Colors.secondaryText
                , backgroundColor Colors.accentBg
                , marginBottom (px -2)
                ]

            else
                []
    in
    div
        [ css
            (List.append selectedStyles
                [ backgroundColor Colors.mainBg
                , displayFlex
                , alignItems center
                , justifyContent center
                , padding (px 5)
                ]
            )
        , Attributes.class "tab"
        ]
        [ text tab.text ]


view : SelectList Tab -> Html msg
view tabs =
    div
        [ css
            [ Css.property "display" "grid"
            , Css.property "grid-area" "tab-list"
            , Css.property "grid-template-columns" "repeat(auto-fill, 140px)"
            , Css.property "grid-column-gap" "2px"
            , padding (px 2)
            , borderBottom3 (px 2) solid Colors.accentBg
            , Css.height (pct 100)
            , Css.property "justify-items" "stretch"
            , Css.property "align-items" "stretch"
            ]
        , Attributes.class "tab-list"
        ]
    <|
        SelectList.toList <|
            SelectList.map (\tab -> viewTab tab (SelectList.selected tabs == tab)) tabs
