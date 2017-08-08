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
import Data.Tag exposing (TagId)
import Dict exposing (Dict)
import Set exposing (Set)
import Util exposing (listToDict)


type alias ProductStore =
    { products : Dict String Product
    , titleFilter : String
    , tagFilter : Maybe TagId
    }


type ProductStoreMsg
    = SetTitleFilter String
    | SetTagFilter (Maybe TagId)


update : ProductStoreMsg -> ProductStore -> ProductStore
update msg productStore =
    case msg of
        SetTitleFilter newTitleFilter ->
            { productStore
                | titleFilter = newTitleFilter
            }

        SetTagFilter newTagFilter ->
            { productStore
                | tagFilter = newTagFilter
            }


filterProductsToSet : (Product -> Bool) -> ProductStore -> Set String
filterProductsToSet predicate productStore =
    Dict.filter (\_ product -> predicate product) productStore.products
        |> Dict.keys
        |> Set.fromList


fromList : List Product -> ProductStore
fromList productList =
    { products = listToDict (Product.toId >> (\(ProductId productId) -> productId)) productList
    , titleFilter = ""
    , tagFilter = Nothing
    }


getProduct : ProductId -> ProductStore -> Maybe Product
getProduct (ProductId productId) productStore =
    Dict.get productId productStore.products


isProductVisible : Product -> ProductStore -> Bool
isProductVisible product { titleFilter, tagFilter } =
    (&&)
        (Product.doesTitleContain titleFilter product)
        (Product.hasTag tagFilter product)


visibleProducts : ProductStore -> List Product
visibleProducts productStore =
    Dict.filter (\_ product -> isProductVisible product productStore) productStore.products
        |> Dict.toList
        |> List.map Tuple.second
