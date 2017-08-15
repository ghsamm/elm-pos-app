module View.MainPanel exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.Product as Product
import Data.ProductStore as ProductStore exposing (ProductStoreMsg(..))
import Data.TagStore as TagStore
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)
import SelectList
import Util exposing (styles)
import View.ProductList as ProductList
import View.TabList as TabList exposing (Tab, TabState(..))
import View.TagList as TagList


viewProductSearch : Html Msg
viewProductSearch =
    div
        [ styles
            [ Css.property "grid-area" "product-search"
            , displayFlex
            , Css.property "animation-delay" "400ms"
            ]
        , Attributes.class "product-search slide-fade-in-to-left"
        ]
        [ input
            [ styles
                [ border zero
                , padding (px 10)
                ]
            , type_ "text"
            , placeholder "Search for products"
            , onInput (\newTitleFilter -> ProductStoreMsg (SetTitleFilter newTitleFilter))
            ]
            []
        ]


view : Model -> Html Msg
view model =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "50px 50px 1fr"
            , Css.property "grid-template-columns" "auto 1fr"
            , Css.property
                "grid-template-areas"
                "'tab-list tab-list' 'product-search tag-list' 'product-list product-list'"
            , Css.property "grid-gap" "10px"
            , overflow Css.hidden
            ]
        , Attributes.class "main-panel"
        ]
        [ TabList.view <|
            SelectList.fromLists
                []
                (Tab "#1520" Editing)
                [ Tab "#1521" Waiting, Tab "#1511" Done ]
        , viewProductSearch
        , TagList.view
            { onClickTag = \maybeTagId -> ProductStoreMsg (SetTagFilter maybeTagId)
            , onClickDefaultTag = \_ -> ProductStoreMsg (SetTagFilter Nothing)
            }
            ( model.tagStore, model.productStore.tagFilter )
        , ProductList.view <|
            (ProductStore.visibleProducts model.productStore
                |> List.map
                    (\product ->
                        let
                            maybeTagId =
                                product |> Product.toTagId

                            tag =
                                maybeTagId
                                    |> Maybe.andThen
                                        (\tagId ->
                                            TagStore.getTag tagId model.tagStore
                                        )
                        in
                        ( product, tag )
                    )
            )
        ]
