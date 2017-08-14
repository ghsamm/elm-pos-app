module App exposing (..)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Data.OrderLineStore as OrderLineStore
import Data.Product as Product exposing (Product, ProductId(..))
import Data.ProductStore as ProductStore
import Data.Tag as Tag exposing (Tag, TagId(..))
import Data.TagStore as TagStore
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Http
import Json.Decode as Json exposing (Decoder)
import Util exposing (styles)
import View.Colors as Colors
import View.MainPanel as MainPanel
import View.MainSidebar as MainSidebar


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
    { productStore = ProductStore.fromList []
    , orderLineStore = OrderLineStore.fromList []
    , tagStore = TagStore.fromList [ tag1, tag2 ]
    }


container : List (Html msg) -> Html msg
container content =
    div
        [ Attributes.class "app-container"
        , styles
            [ Css.height (vh 100)
            , flex (Css.int 1)
            , Css.property "display" "grid"
            , Css.property "grid-template-columns" "400px 1fr"
            , Css.property "grid-gap" "10px"
            , color Colors.mainText
            , backgroundColor Colors.secondaryBg
            , padding (px 10)
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
    let
        productsDecoder : Decoder (List Product)
        productsDecoder =
            Json.list Product.decode

        initProductsRequest =
            Http.get "http://localhost:3001/products" productsDecoder
    in
    ( model
    , Http.send
        (\products -> ProductStoreMsg (ProductStore.Init products))
        initProductsRequest
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

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
