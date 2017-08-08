module View.Product exposing (..)

import Css exposing (..)
import Data.Product as Product exposing (Product, ProductErr, ProductId)
import Data.Tag as Tag exposing (Tag)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)
import Util exposing (formatPrice, styles)
import View.Colors as Colors


viewProductPrice : Float -> Html msg
viewProductPrice productPrice =
    div
        [ styles
            [ position absolute
            , top zero
            , right zero
            , fontSize (Css.em 0.8)
            , padding (px 2)
            , margin (px 2)
            , backgroundColor Colors.secondaryBg
            ]
        , Attributes.class "product__price"
        ]
        [ Html.text <| formatPrice productPrice ]


viewProductName : String -> Html msg
viewProductName productName =
    div
        [ styles
            [ fontSize (Css.em 1.2)
            , textAlign center
            ]
        , Attributes.class "product__name"
        ]
        [ Html.text productName ]


view : (ProductId -> msg) -> ( Product, Maybe Tag ) -> Html msg
view handleClick ( product, maybeTag ) =
    let
        tagStyle =
            case maybeTag of
                Just tag ->
                    [ border3 (px 2) solid (tag |> Tag.toColor) ]

                Nothing ->
                    []
    in
    div
        [ styles
            [ position relative
            , backgroundColor Colors.mainBg
            , displayFlex
            , alignItems center
            , justifyContent center
            , mixin tagStyle
            ]
        , Attributes.class "product"
        , onClick <| handleClick (product |> Product.toId)
        ]
        [ viewProductPrice (product |> Product.toPrice)
        , viewProductName (product |> Product.toName)
        ]
