module Data.Tag
    exposing
        ( Tag
        , TagId(..)
        , fromId
        , toColor
        , toId
        , toName
        , withColor
        , withName
        )

import Css exposing (..)


type TagId
    = TagId String


type Tag
    = Tag
        { id : TagId
        , name : String
        , color : Css.Color
        }


defaultTag : Tag
defaultTag =
    Tag { id = TagId "default-tag-id", name = "default-tag-name", color = hex "000" }


fromId : TagId -> Tag
fromId tagId =
    defaultTag |> withId tagId


toId : Tag -> TagId
toId (Tag tag) =
    tag.id


withId : TagId -> Tag -> Tag
withId newId (Tag tag) =
    Tag { tag | id = newId }


toName : Tag -> String
toName (Tag tag) =
    tag.name


withName : String -> Tag -> Tag
withName newName (Tag tag) =
    Tag { tag | name = newName }


toColor : Tag -> Css.Color
toColor (Tag tag) =
    tag.color


withColor : Color -> Tag -> Tag
withColor newColor (Tag tag) =
    Tag { tag | color = newColor }
