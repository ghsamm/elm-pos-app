module OrderLineTest exposing (..)

import Data.OrderLine exposing (OrderLine, OrderLineId(..))
import Data.Product exposing (Product, ProductId(..))
import Html exposing (..)
import View.OrderLine exposing (view)


orderLine : OrderLine
orderLine =
    OrderLine (OrderLineId "order-line-id") (ProductId "product-id") 1 Nothing


product : Product
product =
    Product (ProductId "product-id") "first-product" 22.5


main : Html msg
main =
    view ( orderLine, product )
