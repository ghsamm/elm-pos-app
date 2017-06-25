module App exposing (..)

import Data.Discount exposing (Discount(..))
import Data.Msg exposing (Msg(..))
import Data.OrderLine exposing (OrderLine, OrderLineId(..))
import Data.Product exposing (Product, ProductId(..))
import Html exposing (..)
import Html.Attributes exposing (class)
import Store.Main exposing (Selection(..), Store)
import Store.OrderLineStore as OrderLineStore
import Store.ProductStore as ProductStore
import View.OrderLineListContainer as OrderLineListContainer
import View.ProductListContainer as ProductListContainer


orderLine1 : OrderLine
orderLine1 =
    OrderLine (OrderLineId "order-line-id-1") (ProductId "product-id-1") 3 (PercentageDiscount 12)


orderLine2 : OrderLine
orderLine2 =
    OrderLine (OrderLineId "order-line-id-2") (ProductId "product-id-1") 4 NoDiscount


product1 : Product
product1 =
    Product (ProductId "product-id-1") "Clavier AZERTY" 22.5


product2 : Product
product2 =
    Product (ProductId "product-id-2") "Souris Gamer" 41.2


store : Store
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
        , ProductListContainer.view model
        ]



-- BOILERPLATE CODE


type alias Model =
    Store


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


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
