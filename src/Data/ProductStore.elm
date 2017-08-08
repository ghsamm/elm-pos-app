module Data.ProductStore
    exposing
        ( ProductStore
        , ProductStoreMsg(..)
        , fromList
        , getProduct
        , update
        , visibleProducts
        )

import Data.Product as Product exposing (Product, ProductId(..), productIdToString)
import Dict exposing (Dict)
import Set exposing (Set)
import Util exposing (listToDict)


type alias ProductStore =
    { products : Dict String Product
    , visibleProducts : Set String
    }


type ProductStoreMsg
    = FilterByString String


update : ProductStoreMsg -> ProductStore -> ProductStore
update msg productStore =
    case msg of
        FilterByString searchString ->
            { productStore
                | visibleProducts =
                    filterProductsToSet
                        (Product.doesTitleMatch searchString)
                        productStore
            }


filterProductsToSet : (Product -> Bool) -> ProductStore -> Set String
filterProductsToSet predicate productStore =
    Dict.filter (\_ product -> predicate product) productStore.products
        |> Dict.keys
        |> Set.fromList


fromList : List Product -> ProductStore
fromList productList =
    { products = listToDict (Product.toId >> productIdToString) productList
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
