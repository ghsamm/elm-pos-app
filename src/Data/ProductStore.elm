module Data.ProductStore exposing (..)

import Data.Product as Product exposing (Product, ProductId(..), productIdToString)
import Dict exposing (Dict)
import Util exposing (storeFromList)


type alias ProductStore =
    { products : Dict String Product
    , visibleProducts : List ProductId
    }


fromList : List Product -> ProductStore
fromList productList =
    { products = storeFromList (Product.toId >> productIdToString) productList
    , visibleProducts = []
    }


getProduct : ProductId -> ProductStore -> Maybe Product
getProduct productId productStore =
    Dict.get (productIdToString productId) productStore.products


isProductVisible : ProductId -> ProductStore -> Bool
isProductVisible productId productStore =
    List.member productId productStore.visibleProducts


visibleProducts : ProductStore -> List Product
visibleProducts productStore =
    Dict.filter (\_ product -> isProductVisible (product |> Product.toId) productStore) productStore.products
        |> Dict.toList
        |> List.map Tuple.second
