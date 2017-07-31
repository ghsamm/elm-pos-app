module Data.Selection exposing (Selection(..), toMaybe)

import Data.OrderLine exposing (OrderLineId)


type Selection id
    = NoSelection
    | SingleSelection id


toMaybe : Selection OrderLineId -> Maybe OrderLineId
toMaybe selection =
    case selection of
        NoSelection ->
            Nothing

        SingleSelection id ->
            Just id
