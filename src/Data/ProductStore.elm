module Data.ProductStore exposing (..)

import Data.Product as Product exposing (Product, ProductId(..), productIdToString)
import Dict exposing (Dict)
import Set exposing (Set)
import Util exposing (storeFromList)


type alias ProductStore =
    { products : Dict String Product
    , visibleProducts : Set String
    }


fromList : List Product -> ProductStore
fromList productList =
    { products = storeFromList (Product.toId >> productIdToString) productList
    , visibleProducts =
        List.map (Product.toId >> productIdToString) productList
            |> Set.fromList
    }


getProduct : ProductId -> ProductStore -> Maybe Product
getProduct productId productStore =
    Dict.get (productIdToString productId) productStore.products


isProductVisible : ProductId -> ProductStore -> Bool
isProductVisible productId productStore =
    Set.member (productId |> productIdToString) productStore.visibleProducts


visibleProducts : ProductStore -> List Product
visibleProducts productStore =
    Dict.filter (\_ product -> isProductVisible (product |> Product.toId) productStore) productStore.products
        |> Dict.toList
        |> List.map Tuple.second
