module View.MainPanel exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLineStore as OrderLineStore
import Data.Product as Product
import Data.ProductStore as ProductStore exposing (ProductStoreMsg(..))
import Data.TagStore as TagStore
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (styles)
import View.ProductList as ProductList
import View.TagList as TagList


view : Model -> Html Msg
view model =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "50px 1fr"
            , Css.property "grid-template-columns" "1fr"
            , Css.property
                "grid-template-areas"
                "'tag-list' 'product-list'"
            , Css.property "grid-gap" "10px"
            , overflow Css.hidden
            ]
        , Attributes.class "main-panel"
        ]
        [ TagList.view
            { onClickTag = \maybeTagId -> ProductStoreMsg (SetTagFilter maybeTagId)
            , onClickDefaultTag = \_ -> ProductStoreMsg (SetTagFilter Nothing)
            }
            ( model.tagStore, model.productStore.tagFilter )
        , ProductList.view <|
            (ProductStore.visibleProducts
                (OrderLineStore.productIdList model.orderLineStore)
                model.productStore
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
