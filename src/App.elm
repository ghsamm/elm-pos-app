module App exposing (..)

import Data.Discount exposing (Discount(..))
import Data.OrderLine exposing (OrderLine, OrderLineId(..))
import Data.Product exposing (Product, ProductId(..))
import Html exposing (..)
import Html.Attributes exposing (class)
import Store.Main exposing (Store)
import Store.OrderLineStore as OrderLineStore
import Store.ProductStore as ProductStore
import View.OrderLineContainer as OrderLineContainer


orderLine : OrderLine
orderLine =
    OrderLine (OrderLineId "order-line-id") (ProductId "product-id") 3 (PercentageDiscount 12)


product : Product
product =
    Product (ProductId "product-id") "Clavier AZERTY" 22.5


store : Store
store =
    { products = ProductStore.fromList [ product ]
    , orderLines = OrderLineStore.fromList [ orderLine ]
    }


container : Html msg -> Html msg
container content =
    div
        [ class "app-container"
        ]
        [ content
        ]


view : Model -> Html Msg
view model =
    container <|
        OrderLineContainer.view (OrderLineId "order-line-id") store



-- BOILERPLATE CODE


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
