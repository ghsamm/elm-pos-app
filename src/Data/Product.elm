module Data.Product
    exposing
        ( Product
        , ProductErr(..)
        , ProductId(..)
        , doesTitleMatch
        , fromId
        , stringToProductId
        , toDiscount
        , toId
        , toName
        , toPrice
        , withDiscount
        , withName
        , withPrice
        )

import Data.Discount exposing (Discount(..))


type Product
    = Product
        { id : ProductId
        , name : String
        , price : Float
        , discount : Discount
        }


type ProductErr
    = ProductNotFound


type ProductId
    = ProductId String


fromId : String -> Product
fromId id =
    defaultProduct |> withId (ProductId id)


withName : String -> Product -> Product
withName newName (Product product) =
    Product { product | name = newName }


toName : Product -> String
toName (Product product) =
    product.name


withId : ProductId -> Product -> Product
withId newId (Product product) =
    Product { product | id = newId }


toId : Product -> ProductId
toId (Product product) =
    product.id


withPrice : Float -> Product -> Product
withPrice newPrice (Product product) =
    Product { product | price = newPrice }


toPrice : Product -> Float
toPrice (Product product) =
    product.price


withDiscount : Discount -> Product -> Product
withDiscount newDiscount (Product product) =
    Product { product | discount = newDiscount }


toDiscount : Product -> Discount
toDiscount (Product product) =
    product.discount


stringToProductId : String -> ProductId
stringToProductId productId =
    ProductId productId


doesTitleMatch : String -> Product -> Bool
doesTitleMatch searchString product =
    case searchString of
        "" ->
            True

        _ ->
            let
                normalizedProductName =
                    product |> toName |> String.toLower

                normalizedSearchString =
                    searchString |> String.trim |> String.toLower
            in
            String.contains normalizedSearchString normalizedProductName



-- INTERNAL


defaultProduct : Product
defaultProduct =
    Product
        { id = ProductId "default-product"
        , name = "(no name)"
        , price = 0
        , discount = NoDiscount
        }
