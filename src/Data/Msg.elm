module Data.Msg exposing (..)

import Data.OrderLineStore exposing (OrderLineStoreMsg)
import Data.Product exposing (Product)
import Data.ProductStore exposing (ProductStoreMsg)
import Data.SideBarRoute exposing (SideBarRoute)
import Data.Tag exposing (Tag)
import Data.TagStore exposing (TagStoreMsg)
import Http


type Msg
    = NoOp
    | Init (Result Http.Error ( List Product, List Tag ))
    | ProductStoreMsg ProductStoreMsg
    | OrderLineStoreMsg OrderLineStoreMsg
    | TagStoreMsg TagStoreMsg
    | SetMainSideBarRoute SideBarRoute
