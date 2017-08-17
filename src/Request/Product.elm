module Request.Product exposing (..)

import Data.Product as Product exposing (Product)
import Http
import Json.Decode as Json exposing (Decoder)


productsDecoder : Decoder (List Product)
productsDecoder =
    Json.list Product.decode


allProducts : Http.Request (List Product)
allProducts =
    Http.get "http://localhost:3001/products" productsDecoder
