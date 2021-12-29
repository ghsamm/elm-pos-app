module Data.OrderLineStore exposing (..)

-- import Data.Product as Product exposing (Product)

import Data.OrderLine as OrderLine exposing (OrderLine, OrderLineId(..))
import Data.Product as Product exposing (Product, ProductId(..))
import Dict exposing (Dict)
import Util exposing (listToDict)


type alias OrderLineStore =
    { orderLines : Dict String OrderLine
    , selectedOrderLine : Maybe OrderLineId
    }


type OrderLineStoreMsg
    = SelectOrderLine OrderLineId
    | SetCurrentOrderLineQuantity Int
    | IncrementCurrentOrderLineQunatity
    | DecrementCurrentOrderLineQunatity
    | DeleteCurrentOrderLine
    | AddProduct Product


selectOrderLine : OrderLineId -> OrderLineStore -> OrderLineStore
selectOrderLine orderLineId orderLineStore =
    { orderLineStore | selectedOrderLine = Just orderLineId }


orderLineIdList : OrderLineStore -> List OrderLineId
orderLineIdList orderLineStore =
    orderLineStore.orderLines
        |> Dict.toList
        |> List.map Tuple.second
        |> List.map OrderLine.toId


productIdList : OrderLineStore -> List ProductId
productIdList orderLineStore =
    orderLineStore.orderLines
        |> Dict.toList
        |> List.map Tuple.second
        |> List.map OrderLine.toProductId


updateOderLine : OrderLineId -> (OrderLine -> OrderLine) -> OrderLineStore -> OrderLineStore
updateOderLine (OrderLineId orderLineId) updater orderLineStore =
    { orderLineStore
        | orderLines = Dict.update orderLineId (Maybe.map updater) orderLineStore.orderLines
    }


updateSelectedOrderLine : (OrderLine -> OrderLine) -> OrderLineStore -> OrderLineStore
updateSelectedOrderLine updater orderLineStore =
    case orderLineStore.selectedOrderLine of
        Just selectedOrderLine ->
            updateOderLine selectedOrderLine updater orderLineStore

        Nothing ->
            orderLineStore


addOrderLineFromProduct : Product -> OrderLineStore -> OrderLineStore
addOrderLineFromProduct product orderLineStore =
    let
        newOrderLine =
            OrderLine.fromProduct product

        productId =
            product |> Product.toId

        orderLineIdString =
            case productId of
                ProductId productIdString ->
                    productIdString
    in
    { orderLineStore
        | orderLines = Dict.insert orderLineIdString newOrderLine orderLineStore.orderLines
        , selectedOrderLine = Just (OrderLineId orderLineIdString)
    }


deleteOrderLine : OrderLineId -> OrderLineStore -> OrderLineStore
deleteOrderLine (OrderLineId orderLineId) orderLineStore =
    { orderLineStore
        | orderLines = Dict.remove orderLineId orderLineStore.orderLines
    }


deleteSelectedOrderLine : OrderLineStore -> OrderLineStore
deleteSelectedOrderLine orderLineStore =
    case orderLineStore.selectedOrderLine of
        Just selectedOrderLine ->
            deleteOrderLine selectedOrderLine orderLineStore

        Nothing ->
            orderLineStore


addProduct : Product -> OrderLineStore -> OrderLineStore
addProduct product orderLineStore =
    let
        maybeOrderLine =
            findOrderLine
                (\orderLine -> OrderLine.toProductId orderLine == Product.toId product)
                orderLineStore
    in
    case maybeOrderLine of
        Just orderLine ->
            orderLineStore

        Nothing ->
            addOrderLineFromProduct product orderLineStore


update : OrderLineStoreMsg -> OrderLineStore -> OrderLineStore
update msg orderLineStore =
    case msg of
        SelectOrderLine orderLineId ->
            selectOrderLine orderLineId orderLineStore

        SetCurrentOrderLineQuantity newQuantity ->
            updateSelectedOrderLine
                (OrderLine.withQuantity newQuantity)
                orderLineStore

        IncrementCurrentOrderLineQunatity ->
            updateSelectedOrderLine
                OrderLine.incrementQuantity
                orderLineStore

        DecrementCurrentOrderLineQunatity ->
            updateSelectedOrderLine
                OrderLine.decrementQuantity
                orderLineStore

        DeleteCurrentOrderLine ->
            deleteSelectedOrderLine orderLineStore

        AddProduct product ->
            addProduct product orderLineStore


fromList : List OrderLine -> OrderLineStore
fromList orderLineList =
    { orderLines = listToDict (OrderLine.toId >> (\(OrderLineId orderLineId) -> orderLineId)) orderLineList
    , selectedOrderLine = Nothing
    }


getOrderLine : OrderLineId -> OrderLineStore -> Maybe OrderLine
getOrderLine (OrderLineId orderLineId) orderLineStore =
    Dict.get orderLineId orderLineStore.orderLines


findOrderLine : (OrderLine -> Bool) -> OrderLineStore -> Maybe OrderLine
findOrderLine predicate orderLineStore =
    Dict.foldl
        (\_ product result ->
            case result of
                Just _ ->
                    result

                Nothing ->
                    if predicate product then
                        Just product
                    else
                        Nothing
        )
        Nothing
        orderLineStore.orderLines



--
-- addProduct : Product -> OrderLineStore -> OrderLineStore
-- addProduct product orderLineStore =
--     let
--         newOrderLine =
--             OrderLine.fromId "fff"
--                 |> OrderLine.withProductId (product |> Product.toId)
--     in
--     { orderLineStore | orderLines = Dict.insert "ffff" newOrderLine orderLineStore.orderLines }
