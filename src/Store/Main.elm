module Store.Main exposing (..)

import Store.OrderLineStore exposing (OrderLineStore)
import Store.ProductStore exposing (ProductStore)


type alias Store =
    { products : ProductStore
    , orderlines : OrderLineStore
    }
