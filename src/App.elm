module App exposing (..)

import Browser
import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Data.OrderLineStore as OrderLineStore
import Data.Product as Product exposing (Product, ProductId(..))
import Data.ProductStore as ProductStore
import Data.SideBarRoute as SideBarRoute
import Data.Tag as Tag exposing (Tag, TagId(..))
import Data.TagStore as TagStore
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import Http
import List exposing ((::))
import Procedure
import Request.Product
import Request.Tag
import Task exposing (Task)
import View.Colors as Colors
import View.ErrorList as ErrorList
import View.MainPanel as MainPanel
import View.MainSidebar as MainSidebar


initialModel : Model
initialModel =
    { productStore = ProductStore.fromList []
    , orderLineStore = OrderLineStore.fromList []
    , tagStore = TagStore.fromList []
    , errors = []
    , sideBarRoute = SideBarRoute.EditCurrentOrder
    }


container : List (Html msg) -> Html msg
container content =
    div
        [ Attributes.class "app-container"
        , css
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


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel
    , Cmd.batch [ Request.Product.allProducts, Request.Tag.allTags ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GotProducts (Err _) ->
            ( { model
                | errors = (::) "Erreur d'accès à la base de donnés" model.errors
              }
            , Cmd.none
            )

        GotProducts (Ok products) ->
            ( { model
                | productStore =
                    ProductStore.update
                        (ProductStore.Init products)
                        model.productStore
              }
            , Cmd.none
            )

        GotTags (Err _) ->
            ( { model
                | errors = (::) "Erreur d'accès à la base de donnés" model.errors
              }
            , Cmd.none
            )

        GotTags (Ok tags) ->
            ( { model
                | tagStore =
                    TagStore.update
                        (TagStore.Init tags)
                        model.tagStore
              }
            , Cmd.none
            )

        OrderLineStoreMsg pageMsg ->
            ( { model | orderLineStore = OrderLineStore.update pageMsg model.orderLineStore }, Cmd.none )

        ProductStoreMsg pageMsg ->
            ( { model | productStore = ProductStore.update pageMsg model.productStore }, Cmd.none )

        TagStoreMsg pageMsg ->
            ( { model | tagStore = TagStore.update pageMsg model.tagStore }, Cmd.none )

        ToggleMainSideBarRoute ->
            ( { model | sideBarRoute = SideBarRoute.toggle model.sideBarRoute }, Cmd.none )


main =
    Browser.element
        { view = view >> toUnstyled
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
