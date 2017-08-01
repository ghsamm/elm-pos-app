module Data.Model exposing (..)

import Data.OrderLine exposing (OrderLine, OrderLineId)
import Data.OrderLineStore as OrderLineStore exposing (OrderLineStore)
import Data.ProductStore exposing (ProductStore)
import Data.Selection as Selection exposing (Selection(..))


type alias Model =
    { productStore : ProductStore
    , orderLineStore : OrderLineStore
    , selectedOrderLine : Selection OrderLineId
    , productSearchString : String
    }
