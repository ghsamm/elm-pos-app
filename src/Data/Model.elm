module Data.Model exposing (..)

import Data.OrderLine exposing (OrderLineId)
import Data.OrderLineStore exposing (OrderLineStore)
import Data.ProductStore exposing (ProductStore)
import Data.Selection as Selection exposing (Selection(..))


type alias Model =
    { products : ProductStore
    , orderLines : OrderLineStore
    , selectedOrderLine : Selection OrderLineId
    , productSearchString : String
    }
