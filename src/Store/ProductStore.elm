module Store.ProductStore exposing (..)

import Data.Product exposing (Product, ProductId(..))
import Dict exposing (Dict)


type alias ProductStore =
    Dict ProductId Product
