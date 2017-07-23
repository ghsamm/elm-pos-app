module Data.ProductStore exposing (..)

import Data.Product as Product exposing (Product, ProductId(..), productIdToString)
import Dict exposing (Dict)
import Util exposing (storeFromList)


type alias ProductStore =
    Dict String Product


fromList : List Product -> ProductStore
fromList =
    storeFromList (Product.toId >> productIdToString)


getProduct : ProductId -> ProductStore -> Maybe Product
getProduct productId productStore =
    Dict.get (productIdToString productId) productStore