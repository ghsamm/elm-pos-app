module Data.Product exposing (..)


type ProductId
    = ProductId String


type alias Product =
    { id : ProductId
    , name : String
    , price : Float
    }


defaultProduct : Product
defaultProduct =
    Product (ProductId "-1") "(no name)" 0


productIdToString : ProductId -> String
productIdToString (ProductId productId) =
    productId
