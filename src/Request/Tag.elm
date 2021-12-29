module Request.Tag exposing (..)

import Data.Msg exposing (Msg(..))
import Data.Tag as Tag exposing (Tag)
import Http
import Json.Decode as Json exposing (Decoder)
import Request.Api as Api


tagsDecoder : Decoder (List Tag)
tagsDecoder =
    Json.list Tag.decode


allTags : Cmd Msg
allTags =
    Http.get
        { url = Api.url ++ "/tags"
        , expect = Http.expectJson GotTags tagsDecoder
        }
