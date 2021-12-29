module Data.Tag exposing
    ( Tag
    , TagId(..)
    , decode
    , decodeId
    , fromId
    , toColor
    , toId
    , toName
    , withColor
    , withName
    )

import Css exposing (Color, hex)
import Json.Decode as Decode exposing (Decoder, string)
import Json.Decode.Pipeline exposing (required)


type TagId
    = TagId String


type alias TagProps =
    { id : TagId
    , name : String
    , color : Css.Color
    }


type Tag
    = Tag TagProps


defaultTag : Tag
defaultTag =
    Tag { id = TagId "default-tag-id", name = "default-tag-name", color = hex "000" }


decodeId : Decoder TagId
decodeId =
    string
        |> Decode.map TagId


decodeColor : Decoder Css.Color
decodeColor =
    string |> Decode.map hex


decode : Decoder Tag
decode =
    Decode.succeed TagProps
        |> required "id" decodeId
        |> required "name" string
        |> required "color" decodeColor
        |> Decode.map Tag


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
