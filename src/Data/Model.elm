module Data.Model exposing (..)

import Data.OrderLineStore as OrderLineStore exposing (OrderLineStore)
import Data.ProductStore exposing (ProductStore)
import Data.TagStore as TagStore exposing (TagStore)


type alias Model =
    { productStore : ProductStore
    , orderLineStore : OrderLineStore
    , tagStore : TagStore
    , productSearchString : String
    }
