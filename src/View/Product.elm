module View.Product exposing (..)

import Css exposing (..)
import Data.Product as Product exposing (Product, ProductErr, ProductId)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)
import Util exposing (formatPrice)


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


view : (ProductId -> msg) -> Result ProductErr Product -> Html msg
view handleClick product =
    case product of
        Err _ ->
            Html.text "this product is unavailable"

        Ok product ->
            div
                [ Attributes.class "product"
                , onClick <| handleClick (product |> Product.toId)
                ]
                [ div
                    [ styles
                        [ position absolute
                        , top zero
                        , right zero
                        , fontSize (Css.em 0.8)
                        , color (hex "000")
                        , backgroundColor (hex "eee")
                        , padding (px 2)
                        , margin (px 2)
                        ]
                    , Attributes.class "product__price"
                    ]
                    [ Html.text <| formatPrice (product |> Product.toPrice) ]
                , div
                    [ styles
                        [ position absolute
                        , bottom zero
                        , left zero
                        , right zero
                        , fontSize (Css.em 0.7)
                        , textAlign center
                        , padding (px 2)
                        , backgroundColor (hex "eee")
                        ]
                    , Attributes.class "product__name"
                    ]
                    [ Html.text (product |> Product.toName) ]
                ]
