module View.OrderLine exposing (view)

import Data.OrderLine exposing (OrderLine, OrderLineErr)
import Data.Product exposing (Product)
import Html exposing (..)
import Html.Attributes exposing (class)


viewName : String -> Html msg
viewName name =
    div [ class "order-line__product-name" ]
        [ Html.text <| name ]


viewPrice : Float -> Html msg
viewPrice price =
    div [ class "order-line__product-price" ]
        [ Html.text <| toString price ++ " DT" ]


viewInfo : OrderLine -> Product -> Html msg
viewInfo orderLine product =
    div [ class "order-line__info" ]
        [ Html.text "info for the product"
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
                , viewInfo orderLine product
                ]
