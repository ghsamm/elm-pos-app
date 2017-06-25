module View.OrderLine exposing (view)

import Data.Discount exposing (Discount(..), applyDiscount, discountToString)
import Data.OrderLine exposing (OrderLine, OrderLineErr)
import Data.Product exposing (Product)
import Html exposing (..)
import Html.Attributes exposing (class)
import Round exposing (round)


viewName : String -> Html msg
viewName name =
    div [ class "order-line__product-name" ]
        [ Html.text <| name ]


formatPrice : Float -> String
formatPrice price =
    Round.round 3 price ++ " DT"


viewUnitPrice : Float -> Html msg
viewUnitPrice price =
    div [ class "order-line__unit-price order-line__text--bold" ]
        [ Html.text <| formatPrice price ]


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


view : Result OrderLineErr ( OrderLine, Product ) -> Html msg
view viewData =
    case viewData of
        Err _ ->
            div [] [ Html.text "this line is invalid" ]

        Ok ( orderLine, product ) ->
            let
                f =
                    Debug.log "product" product
            in
            div [ class "order-line__content" ]
                [ div [ class "order-line__row" ]
                    [ viewName product.name
                    , viewUnitPrice product.price
                    ]
                , hr [] []
                , viewInfo orderLine.quantity product.price orderLine.discount
                ]
