module Types exposing (..)

import RemoteData exposing (WebData)


type ItemId
    = ItemId String


type CategoryId
    = CategoryId String


type alias ShortItemRecord =
    { id : ItemId
    , name : String
    }


type alias FullItemRecord =
    { id : ItemId
    , name : String
    , categoryId : CategoryId
    }


type Item
    = ShortItem ShortItemRecord
    | FullItem FullItemRecord


type ItemStore
    = WebData (List Item)
