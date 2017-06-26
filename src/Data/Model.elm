module Data.Model exposing (..)

import Data.OrderLine exposing (OrderLineId)
import Data.OrderLineStore exposing (OrderLineStore)
import Store.ProductStore exposing (ProductStore)


type Selection id
    = NoSelection
    | SingleSelection id



-- type Store s id
--     = Store s Selection id
--
--
-- type alias DummyStore =
--     Store ProductStore ProductId


type alias Model =
    { products : ProductStore
    , orderLines : OrderLineStore
    , selectedOrderLine : Selection OrderLineId
    , productSearchString : String
    }
