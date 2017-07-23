module App exposing (..)

import Data.Discount exposing (Discount(..))
import Data.Model exposing (Model, Selection(..))
import Data.Msg exposing (Msg(..))
import Data.OrderLine as OrderLine exposing (OrderLine, OrderLineId(..))
import Data.OrderLineStore as OrderLineStore
import Data.Product as Product exposing (Product, ProductId(..))
import Data.ProductStore as ProductStore
import Html exposing (..)
import Html.Attributes exposing (..)
import View.MainPanel as MainPanel
import View.OrderLineListContainer as OrderLineListContainer


product1 : Product
product1 =
    Product.fromId "product-id-1"
        |> Product.withName "Clavier AZERTY"
        |> Product.withPrice 22.5


product2 : Product
product2 =
    Product.fromId "product-id-2"
        |> Product.withName "Souris Gamer"
        |> Product.withPrice 41.2


orderLine1 : OrderLine
orderLine1 =
    OrderLine.fromId "order-line-id-1"
        |> OrderLine.withProductId (product1 |> Product.toId)
        |> OrderLine.withQuantity 3
        |> OrderLine.withDiscount (PercentageDiscount 12)


orderLine2 : OrderLine
orderLine2 =
    OrderLine.fromId "order-line-id-2"
        |> OrderLine.withProductId (product2 |> Product.toId)
        |> OrderLine.withQuantity 4


store : Model
store =
    { products = ProductStore.fromList [ product1, product2 ]
    , orderLines = OrderLineStore.fromList [ orderLine1, orderLine2 ]
    , selectedOrderLine = NoSelection
    , productSearchString = ""
    }


container : List (Html msg) -> Html msg
container content =
    div
        [ class "app-container" ]
        content


view : Model -> Html Msg
view model =
    container <|
        [ OrderLineListContainer.view model
        , MainPanel.view model
        ]


init : ( Model, Cmd Msg )
init =
    ( store, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SelectOrderLine orderLineId ->
            ( { model | selectedOrderLine = SingleSelection orderLineId }, Cmd.none )

        SearchProduct searchString ->
            ( { model | productSearchString = searchString }, Cmd.none )

        AddProductToLineOrderList _ ->
            Debug.crash "TODO"


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
