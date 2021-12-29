module Request.Product exposing (..)

import Data.Msg exposing (Msg(..))
import Data.Product as Product exposing (Product)
import Http
import Json.Decode as Json exposing (Decoder)
import Request.Api as Api


productsDecoder : Decoder (List Product)
productsDecoder =
    Json.list Product.decode


allProducts : Cmd Msg
allProducts =
    Http.get
        { url = Api.url ++ "/products"
        , expect = Http.expectJson GotProducts productsDecoder
        }
