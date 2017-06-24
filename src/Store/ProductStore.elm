module Store.ProductStore exposing (..)

import Data.Product exposing (Product, ProductId(..), productIdToString)
import Dict exposing (Dict)


type alias ProductStore =
    Dict String Product


getProduct : ProductId -> ProductStore -> Maybe Product
getProduct productId productStore =
    Dict.get (productIdToString productId) productStore
