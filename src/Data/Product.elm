module Data.Product exposing (..)


type ProductId
    = ProductId String


type alias Product =
    { id : ProductId
    , name : String
    , price : Float
    }
