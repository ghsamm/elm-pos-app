module Data.ProductStore exposing (..)

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
                    Set.filter
                        (\productIdString ->
                            case searchString of
                                "" ->
                                    True

                                _ ->
                                    let
                                        productName : String
                                        productName =
                                            getProduct (Product.stringToProductId productIdString) productStore
                                                |> Maybe.map Product.toName
                                                |> Maybe.map String.toLower
                                                |> Maybe.withDefault ""
                                    in
                                    String.contains (searchString |> String.toLower) productName
                        )
                        (productIdsAsSet productStore)
            }


productIdsAsSet : ProductStore -> Set String
productIdsAsSet productStore =
    productStore.products
        |> Dict.toList
        |> List.map Tuple.first
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
