module View.OrderLine exposing (view)

import Data.Discount exposing (Discount(..), discountToString)
import Data.OrderLine exposing (OrderLine, OrderLineErr)
import Data.Product exposing (Product)
import Html exposing (..)
import Html.Attributes exposing (class)


viewName : String -> Html msg
viewName name =
    div [ class "order-line__product-name" ]
        [ Html.text <| name ]


formatPrice : Float -> String
formatPrice price =
    toString price ++ " DT"


viewPrice : Float -> Html msg
viewPrice price =
    div [ class "order-line__product-price order-line__text--bold" ]
        [ Html.text <| formatPrice price ]


viewDiscount : Maybe Discount -> Html msg
viewDiscount discount =
    case discount of
        Just discount ->
            text <| " with a discount of " ++ discountToString discount

        Nothing ->
            text ""


viewInfo : Int -> Float -> Maybe Discount -> Html msg
viewInfo quantity unitPrice discount =
    div [ class "order-line__info" ]
        [ span
            [ class "order-line__text--bold" ]
            [ Html.text <| toString quantity ]
        , text " x "
        , span
            [ class "order-line__text--bold" ]
            [ Html.text <| formatPrice unitPrice ]
        , viewDiscount discount
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
                [ div [ class "order-line__first-row" ]
                    [ viewName product.name
                    , viewPrice product.price
                    ]
                , viewInfo orderLine.quantity product.price orderLine.discount
                ]
