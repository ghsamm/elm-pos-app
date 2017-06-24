module Store.OrderLineStore exposing (..)

import Data.OrderLine exposing (OrderLine, OrderLineId(..))
import Dict exposing (Dict)


type alias OrderLineStore =
    Dict OrderLineId OrderLine
