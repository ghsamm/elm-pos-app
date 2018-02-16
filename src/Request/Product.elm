module Request.Product exposing (..)

import Data.Product as Product exposing (Product)
import Http
import Json.Decode as Json exposing (Decoder)
import Request.Api as Api


productsDecoder : Decoder (List Product)
productsDecoder =
    Json.list Product.decode


allProducts : Http.Request (List Product)
allProducts =
    Http.get (Api.url ++ "/products") productsDecoder
