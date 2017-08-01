module Data.ProductStore exposing (..)

import Data.Product as Product exposing (Product, ProductId(..), productIdToString)
import Dict exposing (Dict)
import Util exposing (storeFromList)


type alias ProductStore =
    { products : Dict String Product
    , visibleProducts : List ProductId
    , filters : List (Product -> Bool)
    }


fromList : List Product -> ProductStore
fromList productList =
    { products = storeFromList (Product.toId >> productIdToString) productList
    , visibleProducts = List.map Product.toId productList
    , filters = []
    }


addFilter : (Product -> Bool) -> ProductStore -> ProductStore
addFilter newFilter productStore =
    { productStore | filters = newFilter :: productStore.filters }


applyFilters : ProductStore -> ProductStore
applyFilters productStore =
    { productStore
        | visibleProducts =
            productStore.products
                |> Dict.toList
                |> List.map Tuple.second
                |> List.filter (\product -> List.all (\filter -> filter product) productStore.filters)
                |> List.map Product.toId
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
