module Data.Model exposing (..)

import Data.OrderLineStore as OrderLineStore exposing (OrderLineStore)
import Data.ProductStore exposing (ProductStore)


type alias Model =
    { productStore : ProductStore
    , orderLineStore : OrderLineStore
    , productSearchString : String
    }
