module Data.OrderLine exposing
    ( OrderLine
    , OrderLineId(..)
    , decrementQuantity
    , fromId
    , fromProduct
    , incrementQuantity
    , stringToOrderLineId
    , toId
    , toPrice
    , toProductId
    , toProductName
    , toProductPrice
    , toQuantity
    , withId
    , withProductId
    , withQuantity
    )

import Data.Product as Product exposing (Product, ProductId(..))


type OrderLineId
    = OrderLineId String


type OrderLine
    = OrderLine
        { id : OrderLineId
        , productId : ProductId
        , productName : String
        , productPrice : Float
        , quantity : Int
        }


defaultOrderLine : OrderLine
defaultOrderLine =
    OrderLine
        { id = OrderLineId "no-id"
        , productId = ProductId "no-id"
        , productName = ""
        , productPrice = 0
        , quantity = 1
        }


fromId : String -> OrderLine
fromId id =
    defaultOrderLine |> withId (OrderLineId id)


fromProduct : Product -> OrderLine
fromProduct product =
    let
        productId =
            Product.toId product

        productName =
            Product.toName product

        productPrice =
            Product.toPrice product

        productIdString =
            case productId of
                ProductId stringId ->
                    stringId
    in
    fromId productIdString
        |> withProductId productId
        |> withProductName productName
        |> withProductPrice productPrice


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


withProductName : String -> OrderLine -> OrderLine
withProductName newProductName (OrderLine orderLine) =
    OrderLine { orderLine | productName = newProductName }


toProductName : OrderLine -> String
toProductName (OrderLine orderLine) =
    orderLine.productName


withProductPrice : Float -> OrderLine -> OrderLine
withProductPrice newProductPrice (OrderLine orderLine) =
    OrderLine { orderLine | productPrice = newProductPrice }


toProductPrice : OrderLine -> Float
toProductPrice (OrderLine orderLine) =
    orderLine.productPrice


withQuantity : Int -> OrderLine -> OrderLine
withQuantity newQuantity (OrderLine orderLine) =
    OrderLine { orderLine | quantity = newQuantity }


toPrice : OrderLine -> Float
toPrice (OrderLine orderLine) =
    orderLine.productPrice * toFloat orderLine.quantity


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


stringToOrderLineId : String -> OrderLineId
stringToOrderLineId orderLineId =
    OrderLineId orderLineId
