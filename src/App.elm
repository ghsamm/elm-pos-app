module App exposing (..)

import Data.OrderLine exposing (OrderLine, OrderLineId(..))
import Data.Product exposing (Product, ProductId(..))
import Html exposing (..)
import Store.Main exposing (Store)
import Store.OrderLineStore as OrderLineStore
import Store.ProductStore as ProductStore
import View.OrderLineContainer as OrderLineContainer


orderLine : OrderLine
orderLine =
    OrderLine (OrderLineId "order-line-id") (ProductId "product-id") 1 Nothing


product : Product
product =
    Product (ProductId "product-id") "first-product" 22.5


store : Store
store =
    { products = ProductStore.fromList [ product ]
    , orderLines = OrderLineStore.fromList [ orderLine ]
    }


view : Model -> Html Msg
view model =
    OrderLineContainer.view (OrderLineId "order-line-id") store


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
