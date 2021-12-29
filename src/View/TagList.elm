module View.TagList exposing (..)

import Css exposing (..)
import Data.Tag as Tag exposing (Tag, TagId(..))
import Data.TagStore exposing (TagStore)
import Dict
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Intl exposing (intl)
import Tuple
import View.Colors as Colors


defaultTag : Tag
defaultTag =
    Tag.fromId (TagId "default-tag")
        |> Tag.withName intl.allCategories
        |> Tag.withColor (hex "ababab")


viewTag : (Maybe TagId -> msg) -> ( Tag, Bool ) -> Html msg
viewTag handleClick ( tag, isSelected ) =
    let
        selectedStyle =
            if isSelected then
                [ border3 (px 2) solid (tag |> Tag.toColor)
                , color (tag |> Tag.toColor)
                ]

            else
                [ borderBottom3 (px 2) solid (tag |> Tag.toColor) ]
    in
    a
        [ css
            (List.append selectedStyle
                [ displayFlex
                , alignItems center
                , justifyContent center
                , padding (px 10)
                , marginRight (px 5)
                , backgroundColor Colors.mainBg
                ]
            )
        , Attributes.class "tag"
        , Attributes.href "#"
        , onClick <| handleClick (tag |> Tag.toId |> Just)
        ]
        [ text (tag |> Tag.toName) ]


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
        [ css
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
