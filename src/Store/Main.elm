module Store.Main exposing (..)

import Data.OrderLine exposing (OrderLineId)
import Store.OrderLineStore exposing (OrderLineStore)
import Store.ProductStore exposing (ProductStore)


type Selection id
    = NoSelection
    | SingleSelection id


type alias Store =
    { products : ProductStore
    , orderLines : OrderLineStore
    , selectedOrderLine : Selection OrderLineId
    }
