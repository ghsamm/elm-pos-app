module Data.ProductStore
    exposing
        ( ProductStore
        , ProductStoreMsg(..)
        , fromList
        , getProduct
        , update
        , visibleProducts
        )

import Data.Product as Product exposing (Product, ProductId(..))
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
                        (Product.doesTitleContain searchString)
                        productStore
            }


filterProductsToSet : (Product -> Bool) -> ProductStore -> Set String
filterProductsToSet predicate productStore =
    Dict.filter (\_ product -> predicate product) productStore.products
        |> Dict.keys
        |> Set.fromList


fromList : List Product -> ProductStore
fromList productList =
    { products = listToDict (Product.toId >> (\(ProductId productId) -> productId)) productList
    , visibleProducts =
        List.map (Product.toId >> (\(ProductId productId) -> productId)) productList
            |> Set.fromList
    }


getProduct : ProductId -> ProductStore -> Maybe Product
getProduct (ProductId productId) productStore =
    Dict.get productId productStore.products


isProductVisible : ProductId -> ProductStore -> Bool
isProductVisible (ProductId productId) productStore =
    Set.member productId productStore.visibleProducts


visibleProducts : ProductStore -> List Product
visibleProducts productStore =
    Dict.filter (\_ product -> isProductVisible (product |> Product.toId) productStore) productStore.products
        |> Dict.toList
        |> List.map Tuple.second
