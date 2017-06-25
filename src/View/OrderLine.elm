module View.OrderLine exposing (view)

import Data.Discount exposing (Discount(..), applyDiscount, discountToString)
import Data.OrderLine exposing (OrderLine, OrderLineErr, OrderLineId)
import Data.Product exposing (Product)
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (..)
import Util exposing (formatPrice)


viewName : String -> Html msg
viewName name =
    div [ class "order-line__product-name" ]
        [ Html.text <| name ]


viewUnitPriceBeforeDiscount : Float -> Discount -> Html msg
viewUnitPriceBeforeDiscount price discount =
    case discount of
        NoDiscount ->
            span [ class "order-line__unit-price--new" ] [ text <| formatPrice price ]

        _ ->
            span [ class "order-line__unit-price--old" ] [ text <| formatPrice price ]


viewUnitPriceAfterDiscount : Float -> Discount -> Html msg
viewUnitPriceAfterDiscount price discount =
    case discount of
        NoDiscount ->
            text ""

        _ ->
            span [ class "order-line__unit-price--new" ] [ text <| formatPrice <| applyDiscount discount price ]


viewUnitPrice : Float -> Discount -> Html msg
viewUnitPrice price discount =
    div [ class "order-line__unit-price order-line__text--bold" ]
        [ viewUnitPriceBeforeDiscount price discount
        , text " "
        , viewUnitPriceAfterDiscount price discount
        ]



-- ,Html.text <| formatPrice price ]


viewDiscount : Discount -> Html msg
viewDiscount discount =
    let
        textData =
            case discount of
                NoDiscount ->
                    text ""

                _ ->
                    span []
                        [ text "* with a discount of "
                        , span [ class "order-line__text--bold" ]
                            [ text <| discountToString discount ]
                        ]
    in
    div [ class "order-line__discount" ] [ textData ]


viewTotalPrice : Int -> Float -> Discount -> Html msg
viewTotalPrice quantity unitPrice discount =
    span
        [ class "order-line__total-price order-line__text--bold" ]
        [ text <| formatPrice <| applyDiscount discount <| toFloat quantity * unitPrice ]


viewBottomLine : Int -> Float -> Discount -> Html msg
viewBottomLine quantity unitPrice discount =
    div [ class "order-line__bottom-line" ]
        [ text " x "
        , span
            [ class "order-line__text--bold" ]
            [ Html.text <| toString quantity ]
        , text " = "
        , viewTotalPrice quantity unitPrice discount
        ]


viewInfo : Int -> Float -> Discount -> Html msg
viewInfo quantity unitPrice discount =
    div
        [ class "order-line__info order-line__row" ]
        [ viewDiscount discount
        , viewBottomLine quantity unitPrice discount
        ]


view : (OrderLineId -> msg) -> Result OrderLineErr ( OrderLine, Product ) -> Html msg
view handleClick viewData =
    case viewData of
        Err _ ->
            div [] [ Html.text "this line is invalid" ]

        Ok ( orderLine, product ) ->
            div
                [ class "order-line__content"
                , onClick (handleClick orderLine.id)
                ]
                [ div
                    [ class "order-line__row order-line__top-row"
                    ]
                    [ viewName product.name
                    , viewUnitPrice product.price orderLine.discount
                    ]
                , hr [] []
                , viewInfo orderLine.quantity product.price orderLine.discount
                ]
