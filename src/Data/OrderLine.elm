module Data.OrderLine
    exposing
        ( OrderLine
        , OrderLineErr(..)
        , OrderLineId(..)
        , decrementQuantity
        , fromId
        , fromProduct
        , incrementQuantity
        , stringToOrderLineId
        , toDiscount
        , toId
        , toProductId
        , toQuantity
        , withDiscount
        , withId
        , withProductId
        , withQuantity
        )

import Data.Discount exposing (Discount(..))
import Data.Product as Product exposing (Product, ProductId(..))


type OrderLineId
    = OrderLineId String


type OrderLine
    = OrderLine
        { id : OrderLineId
        , productId : ProductId
        , quantity : Int
        , discount : Discount
        }


type OrderLineErr
    = OrderLineNotFound
    | ProductNotFound


defaultOrderLine : OrderLine
defaultOrderLine =
    OrderLine
        { id = OrderLineId "no-id"
        , productId = ProductId "no-i"
        , quantity = 1
        , discount = NoDiscount
        }


fromId : String -> OrderLine
fromId id =
    defaultOrderLine |> withId (OrderLineId id)


fromProduct : Product -> OrderLine
fromProduct product =
    let
        productId =
            Product.toId product

        productIdString =
            case productId of
                ProductId stringId ->
                    stringId
    in
    fromId productIdString
        |> withProductId productId


withId : OrderLineId -> OrderLine -> OrderLine
withId newId (OrderLine orderLine) =
    OrderLine { orderLine | id = newId }


toId : OrderLine -> OrderLineId
toId (OrderLine orderLine) =
    orderLine.id


withProductId : ProductId -> OrderLine -> OrderLine
withProductId newProductId (OrderLine orderLine) =
    OrderLine { orderLine | productId = newProductId }


toProductId : OrderLine -> ProductId
toProductId (OrderLine orderLine) =
    orderLine.productId


withQuantity : Int -> OrderLine -> OrderLine
withQuantity newQuantity (OrderLine orderLine) =
    OrderLine { orderLine | quantity = newQuantity }


incrementQuantity : OrderLine -> OrderLine
incrementQuantity orderLine =
    withQuantity
        (toQuantity orderLine + 1)
        orderLine


decrementQuantity : OrderLine -> OrderLine
decrementQuantity orderLine =
    withQuantity
        (max 1 <| toQuantity orderLine - 1)
        orderLine


toQuantity : OrderLine -> Int
toQuantity (OrderLine orderLine) =
    orderLine.quantity


withDiscount : Discount -> OrderLine -> OrderLine
withDiscount newDiscount (OrderLine orderLine) =
    OrderLine { orderLine | discount = newDiscount }


toDiscount : OrderLine -> Discount
toDiscount (OrderLine orderLine) =
    orderLine.discount


stringToOrderLineId : String -> OrderLineId
stringToOrderLineId orderLineId =
    OrderLineId orderLineId
