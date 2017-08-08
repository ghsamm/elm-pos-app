module View.TagList exposing (..)

import Css exposing (..)
import Data.Tag as Tag exposing (Tag)
import Data.TagStore exposing (TagStore)
import Dict
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Tuple
import Util exposing (styles)
import View.Colors as Colors


viewTag : Tag -> Html msg
viewTag tag =
    a
        [ styles
            [ displayFlex
            , alignItems center
            , justifyContent center
            , borderBottom3 (px 2) solid (tag |> Tag.toColor)
            , padding (px 10)
            , marginRight (px 5)
            , backgroundColor Colors.mainBg
            ]
        , Attributes.class "tag"
        , Attributes.href "#"
        ]
        [ Html.text (tag |> Tag.toName) ]


view : TagStore -> Html msg
view tagStore =
    div
        [ styles
            [ Css.property "grid-area" "tag-list"
            , displayFlex
            , alignItems stretch
            ]
        , Attributes.class "tag-list"
        ]
        (tagStore.tags
            |> Dict.toList
            |> List.map Tuple.second
            |> List.map
                viewTag
        )
