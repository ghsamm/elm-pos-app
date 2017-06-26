module Data.Model exposing (..)

import Data.OrderLine exposing (OrderLineId)
import Store.OrderLineStore exposing (OrderLineStore)
import Store.ProductStore exposing (ProductStore)


type Selection id
    = NoSelection
    | SingleSelection id


type alias Model =
    { products : ProductStore
    , orderLines : OrderLineStore
    , selectedOrderLine : Selection OrderLineId
    , productSearchString : String
    }
