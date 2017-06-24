module Transition.Product exposing (..)

import Data.Product exposing (Product)


rename : String -> Product -> Product
rename newName product =
    { product
        | name = newName
    }


setPrice : Float -> Product -> Product
setPrice newPrice product =
    { product
        | price = newPrice
    }
