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

import Css exposing (Color, hex)
import Json.Decode as Json exposing (Decoder, string)
import Json.Decode.Pipeline as JsonPipeline exposing (required)


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
        |> Json.map TagId


decodeColor : Decoder Css.Color
decodeColor =
    string |> Json.map hex


decode : Decoder Tag
decode =
    Json.map Tag
        (JsonPipeline.decode TagProps
            |> required "id" decodeId
            |> required "name" string
            |> required "color" decodeColor
        )


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
