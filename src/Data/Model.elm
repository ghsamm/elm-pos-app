module Data.Model exposing (..)

import Data.OrderLineStore as OrderLineStore exposing (OrderLineStore)
import Data.ProductStore exposing (ProductStore)
import Data.SideBarRoute exposing (SideBarRoute)
import Data.TagStore as TagStore exposing (TagStore)


type alias Model =
    { productStore : ProductStore
    , orderLineStore : OrderLineStore
    , tagStore : TagStore
    , errors : List String
    , sideBarRoute : SideBarRoute
    }
