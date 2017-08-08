module Data.TagStore exposing (..)

import Data.Tag as Tag exposing (Tag, TagId(..))
import Dict exposing (Dict)
import Util exposing (listToDict)


type alias TagStore =
    { tags : Dict String Tag
    }


fromList : List Tag -> TagStore
fromList tagList =
    { tags = listToDict (Tag.toId >> (\(TagId tagId) -> tagId)) tagList
    }


getTag : TagId -> TagStore -> Maybe Tag
getTag (TagId tagId) tagStore =
    Dict.get tagId tagStore.tags
