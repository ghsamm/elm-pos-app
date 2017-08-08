module App exposing (..)

import Css exposing (..)
import Data.Discount exposing (Discount(..))
import Data.Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Data.OrderLine as OrderLine exposing (OrderLine, OrderLineId(..))
import Data.OrderLineStore as OrderLineStore
import Data.Product as Product exposing (Product, ProductId(..))
import Data.ProductStore as ProductStore
import Data.Tag as Tag exposing (Tag, TagId(..))
import Data.TagStore as TagStore
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (styles)
import View.Colors as Colors
import View.MainPanel as MainPanel
import View.MainSidebar as MainSidebar


product1 : Product
product1 =
    Product.fromId "product-id-1"
        |> Product.withName "Clavier AZERTY"
        |> Product.withPrice 22.5
        |> Product.withTag (TagId "tag-id-1")


product2 : Product
product2 =
    Product.fromId "product-id-2"
        |> Product.withName "Souris Gamer"
        |> Product.withPrice 41.2
        |> Product.withTag (TagId "tag-id-2")


product3 : Product
product3 =
    Product.fromId "product-id-3"
        |> Product.withName "Souris Gamer 2"
        |> Product.withPrice 41.2
        |> Product.withTag (TagId "tag-id-12")


product4 : Product
product4 =
    Product.fromId "product-id-4"
        |> Product.withName "Souris Gamer 3"
        |> Product.withPrice 41.2
        |> Product.withTag (TagId "tag-id-1")


product5 : Product
product5 =
    Product.fromId "product-id-5"
        |> Product.withName "Souris Gamer 5"
        |> Product.withPrice 41.2
        |> Product.withTag (TagId "tag-id-2")


product6 : Product
product6 =
    Product.fromId "product-id-6"
        |> Product.withName "Souris Gamer 6"
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


tag1 : Tag
tag1 =
    Tag.fromId (TagId "tag-id-1")
        |> Tag.withName "Tag number one"
        |> Tag.withColor (hex "11b34c")


tag2 : Tag
tag2 =
    Tag.fromId (TagId "tag-id-2")
        |> Tag.withName "Tag number two"
        |> Tag.withColor (hex "60c3ff")


model : Model
model =
    { productStore =
        ProductStore.fromList
            [ product1
            , product2
            , product3
            , product4
            , product5
            , product6
            ]
    , orderLineStore = OrderLineStore.fromList [ orderLine1, orderLine2 ]
    , tagStore = TagStore.fromList [ tag1, tag2 ]
    }


container : List (Html msg) -> Html msg
container content =
    div
        [ Attributes.class "app-container"
        , styles
            [ Css.height (vh 100)
            , flex (int 1)
            , Css.property "display" "grid"
            , Css.property "grid-template-columns" "400px 1fr"
            , color Colors.mainText
            , backgroundColor Colors.secondaryBg
            ]
        ]
        content


view : Model -> Html Msg
view model =
    container <|
        [ MainSidebar.view model
        , MainPanel.view model
        ]


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        -- SearchProduct searchString ->
        --     ( { model
        --         | productSearchString = searchString
        --         , productStore = ProductStore.update (ProductStore.FilterByString searchString) model.productStore
        --       }
        --     , Cmd.none
        --     )
        OrderLineStoreMsg msg ->
            ( { model | orderLineStore = OrderLineStore.update msg model.orderLineStore }, Cmd.none )

        ProductStoreMsg msg ->
            ( { model | productStore = ProductStore.update msg model.productStore }, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
