module Request.Tag exposing (..)

import Data.Tag as Tag exposing (Tag)
import Http
import Json.Decode as Json exposing (Decoder)


tagsDecoder : Decoder (List Tag)
tagsDecoder =
    Json.list Tag.decode


allTags : Http.Request (List Tag)
allTags =
    Http.get "http://localhost:3001/tags" tagsDecoder
