module Data.User exposing (..)


type UserId
    = UserId String


type Username
    = Username String


type alias User =
    { id : UserId
    , username : Username
    , createdAt : String
    , updatedAt : String
    }
