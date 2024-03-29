module Data.TagStore exposing (..)

import Data.Tag as Tag exposing (Tag, TagId(..))
import Dict exposing (Dict)
import Util exposing (listToDict)


type alias TagStore =
    { tags : Dict String Tag
    }


type TagStoreMsg
    = Init (List Tag)


update : TagStoreMsg -> TagStore -> TagStore
update msg tagStore =
    case msg of
        Init tags ->
            fromList tags


fromList : List Tag -> TagStore
fromList tagList =
    { tags = listToDict (Tag.toId >> (\(TagId tagId) -> tagId)) tagList
    }


getTag : TagId -> TagStore -> Maybe Tag
getTag (TagId tagId) tagStore =
    Dict.get tagId tagStore.tags
