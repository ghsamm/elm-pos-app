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
import List exposing ((::))
import Request.Product
import Request.Tag
import Task exposing (Task)
import Util exposing (styles)
import View.Colors as Colors
import View.ErrorList as ErrorList
import View.MainPanel as MainPanel
import View.MainSidebar as MainSidebar


model : Model
model =
    { productStore = ProductStore.fromList []
    , orderLineStore = OrderLineStore.fromList []
    , tagStore = TagStore.fromList []
    , errors = []
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
        , ErrorList.view model.errors
        ]


init : ( Model, Cmd Msg )
init =
    let
        initProductsRequestTask : Task Http.Error (List Product)
        initProductsRequestTask =
            Http.toTask <|
                Request.Product.allProducts

        initTagsRequestTask : Task Http.Error (List Tag)
        initTagsRequestTask =
            Http.toTask <|
                Request.Tag.allTags

        task : Task Http.Error ( List Product, List Tag )
        task =
            Task.map2 (\products tags -> ( products, tags ))
                initProductsRequestTask
                initTagsRequestTask
    in
    ( model
    , Task.attempt Init task
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Init (Err _) ->
            ( { model
                | errors = (::) "Erreur d'accès à la base de donnés" model.errors
              }
            , Cmd.none
            )

        Init (Ok ( products, tags )) ->
            ( { model
                | productStore =
                    ProductStore.update
                        (ProductStore.Init products)
                        model.productStore
                , tagStore =
                    TagStore.update
                        (TagStore.Init tags)
                        model.tagStore
              }
            , Cmd.none
            )

        OrderLineStoreMsg msg ->
            ( { model | orderLineStore = OrderLineStore.update msg model.orderLineStore }, Cmd.none )

        ProductStoreMsg msg ->
            ( { model | productStore = ProductStore.update msg model.productStore }, Cmd.none )

        TagStoreMsg msg ->
            ( { model | tagStore = TagStore.update msg model.tagStore }, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
