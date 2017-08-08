module View.TagList exposing (..)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (styles)
import View.Colors as Colors


type alias Tag =
    { name : String
    , color : Css.Color
    }


viewTag : Tag -> Html msg
viewTag tag =
    div
        [ styles
            [ displayFlex
            , alignItems center
            , justifyContent center
            , borderBottom3 (px 2) solid tag.color
            , padding (px 10)
            , marginRight (px 5)
            , backgroundColor Colors.mainBg
            ]
        , Attributes.class "tag"
        ]
        [ Html.text tag.name ]


view : List Tag -> Html msg
view tags =
    div
        [ styles
            [ Css.property "grid-area" "tag-list"
            , displayFlex
            , alignItems stretch
            ]
        , Attributes.class "tag-list"
        ]
        (List.map viewTag tags)
