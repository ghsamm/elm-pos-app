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
import Util exposing (listToDict)


type alias ProductStore =
    { products : Dict String Product
    , titleFilter : String
    , tagFilter : Maybe TagId
    }


type ProductStoreMsg
    = Init (List Product)
    | SetTitleFilter String
    | SetTagFilter (Maybe TagId)


update : ProductStoreMsg -> ProductStore -> ProductStore
update msg productStore =
    case msg of
        Init products ->
            fromList products

        SetTitleFilter newTitleFilter ->
            { productStore
                | titleFilter = newTitleFilter
            }

        SetTagFilter newTagFilter ->
            { productStore
                | tagFilter = newTagFilter
            }


fromList : List Product -> ProductStore
fromList productList =
    { products = listToDict (Product.toId >> (\(ProductId productId) -> productId)) productList
    , titleFilter = ""
    , tagFilter = Nothing
    }


getProduct : ProductId -> ProductStore -> Maybe Product
getProduct (ProductId productId) productStore =
    Dict.get productId productStore.products


isProductVisible : Product -> List ProductId -> ProductStore -> Bool
isProductVisible product excludedProductIds { titleFilter, tagFilter } =
    Product.doesTitleContain titleFilter product
        && Product.hasTag tagFilter product
        && not (List.member (Product.toId product) excludedProductIds)


visibleProducts : List ProductId -> ProductStore -> List Product
visibleProducts excludedProductIds productStore =
    Dict.filter (\_ product -> isProductVisible product excludedProductIds productStore) productStore.products
        |> Dict.toList
        |> List.map Tuple.second
