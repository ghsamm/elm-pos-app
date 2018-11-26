module Data.Product exposing
    ( Product
    , ProductId(..)
    , decode
    , doesTitleContain
    , fromId
    , hasTag
    , stringToProductId
    , toId
    , toName
    , toPrice
    , toTagId
    , withName
    , withPrice
    , withTag
    )

import Data.Tag as Tag exposing (TagId)
import Json.Decode as Json exposing (Decoder, float, maybe, string)
import Json.Decode.Pipeline as JsonPipeline exposing (hardcoded, optional, required)


type alias ProductProps =
    { id : ProductId
    , name : String
    , price : Float
    , tag : Maybe TagId
    }


type Product
    = Product ProductProps


type ProductId
    = ProductId String


decodeId : Decoder ProductId
decodeId =
    string
        |> Json.map ProductId


decode : Decoder Product
decode =
    Json.map Product
        (JsonPipeline.decode ProductProps
            |> required "id" decodeId
            |> required "name" string
            |> required "price" float
            |> optional "tag_id" (Json.map Just Tag.decodeId) Nothing
        )


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


withTag : TagId -> Product -> Product
withTag newTag (Product product) =
    Product { product | tag = Just newTag }


withoutTag : Product -> Product
withoutTag (Product product) =
    Product { product | tag = Nothing }


toTagId : Product -> Maybe TagId
toTagId (Product product) =
    product.tag


stringToProductId : String -> ProductId
stringToProductId productId =
    ProductId productId


doesTitleContain : String -> Product -> Bool
doesTitleContain searchString product =
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


hasTag : Maybe TagId -> Product -> Bool
hasTag maybeTagId product =
    case maybeTagId of
        Nothing ->
            True

        Just _ ->
            toTagId product == maybeTagId



-- INTERNAL


defaultProduct : Product
defaultProduct =
    Product
        { id = ProductId "default-product"
        , name = "(no name)"
        , price = 0
        , tag = Nothing
        }
