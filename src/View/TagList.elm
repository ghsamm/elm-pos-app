module View.TagList exposing (..)

import Css exposing (..)
import Data.Tag as Tag exposing (Tag, TagId(..))
import Data.TagStore as TagStore exposing (TagStore)
import Dict
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)
import Intl exposing (intl)
import Tuple
import Util exposing ((=>), styles)
import View.Colors as Colors


defaultTag : Tag
defaultTag =
    Tag.fromId (TagId "default-tag")
        |> Tag.withName intl.allCategories
        |> Tag.withColor (hex "ababab")


viewTag : (Maybe TagId -> msg) -> ( Tag, Bool ) -> Html msg
viewTag handleClick ( tag, isSelected ) =
    let
        selectedStyleMixin =
            case isSelected of
                True ->
                    mixin
                        [ border3 (px 2) solid (tag |> Tag.toColor)
                        , color (tag |> Tag.toColor)
                        ]

                False ->
                    mixin [ borderBottom3 (px 2) solid (tag |> Tag.toColor) ]
    in
    a
        [ styles
            [ displayFlex
            , alignItems center
            , justifyContent center
            , padding (px 10)
            , marginRight (px 5)
            , backgroundColor Colors.mainBg
            , selectedStyleMixin
            ]
        , Attributes.class "tag"
        , Attributes.href "#"
        , onClick <| handleClick (tag |> Tag.toId |> Just)
        ]
        [ Html.text (tag |> Tag.toName) ]


type alias ViewListeners msg =
    { onClickTag : Maybe TagId -> msg
    , onClickDefaultTag : Maybe TagId -> msg
    }


view : ViewListeners msg -> ( TagStore, Maybe TagId ) -> Html msg
view { onClickTag, onClickDefaultTag } ( tagStore, selectedTagId ) =
    let
        isTagSelected : Tag -> Bool
        isTagSelected tag =
            selectedTagId == Just (Tag.toId tag)
    in
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
            |> List.map (\tag -> ( tag, isTagSelected tag ))
            |> List.map (viewTag onClickTag)
            |> (::) (viewTag onClickDefaultTag ( defaultTag, isTagSelected defaultTag ))
        )
