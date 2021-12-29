module Data.Msg exposing (..)

import Data.OrderLineStore exposing (OrderLineStoreMsg)
import Data.Product exposing (Product)
import Data.ProductStore exposing (ProductStoreMsg)
import Data.Tag exposing (Tag)
import Data.TagStore exposing (TagStoreMsg)
import Http


type Msg
    = NoOp
    | ProductStoreMsg ProductStoreMsg
    | OrderLineStoreMsg OrderLineStoreMsg
    | TagStoreMsg TagStoreMsg
    | ToggleMainSideBarRoute
    | GotProducts (Result Http.Error (List Product))
    | GotTags (Result Http.Error (List Tag))
