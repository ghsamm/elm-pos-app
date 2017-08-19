module View.OrderLine exposing (view)

import Css exposing (..)
import Data.Discount exposing (Discount(..), applyDiscount, discountToString)
import Data.OrderLine as OrderLine exposing (OrderLine, OrderLineId)
import Data.Product as Product exposing (Product)
import Html exposing (..)
import Html.Attributes as Attributes exposing (class, classList)
import Html.Events exposing (..)
import Util exposing (formatPrice, styles)
import View.Colors as Colors


mixins : { boldText : Mixin }
mixins =
    { boldText = fontWeight bold
    }


viewName : String -> Html msg
viewName name =
    div [ Attributes.class "order-line__product-name" ]
        [ Html.text <| name ]


viewUnitPriceBeforeDiscount : Float -> Discount -> Html msg
viewUnitPriceBeforeDiscount price discount =
    let
        attributes =
            case discount of
                NoDiscount ->
                    [ Attributes.class "order-line__unit-price--new" ]

                _ ->
                    [ Attributes.class "order-line__unit-price--old"
                    , styles
                        [ textDecoration lineThrough
                        , fontSize (Css.em 0.8)
                        , fontWeight normal
                        ]
                    ]
    in
    span attributes [ Html.text <| formatPrice price ]


viewUnitPriceAfterDiscount : Float -> Discount -> Html msg
viewUnitPriceAfterDiscount price discount =
    case discount of
        NoDiscount ->
            Html.text ""

        _ ->
            span [ Attributes.class "order-line__unit-price--new" ] [ Html.text <| formatPrice <| applyDiscount discount price ]


viewUnitPrice : Float -> Discount -> Html msg
viewUnitPrice price discount =
    div
        [ styles [ mixins.boldText, Css.property "justify-self" "flex-end" ]
        , Attributes.class "order-line__unit-price"
        ]
        [ viewUnitPriceBeforeDiscount price discount
        , Html.text " "
        , viewUnitPriceAfterDiscount price discount
        ]



-- ,Html.text <| formatPrice price ]


viewDiscount : Discount -> Html msg
viewDiscount discount =
    let
        textData =
            case discount of
                NoDiscount ->
                    Html.text ""

                _ ->
                    span []
                        [ Html.text "* with a discount of "
                        , span [ styles [ mixins.boldText ] ]
                            [ Html.text <| discountToString discount ]
                        ]
    in
    div
        [ styles
            [ fontSize (Css.em 0.8)
            , fontStyle italic
            ]
        , Attributes.class "order-line__discount"
        ]
        [ textData ]


viewTotalPrice : Int -> Float -> Discount -> Html msg
viewTotalPrice quantity unitPrice discount =
    span
        [ styles [ mixins.boldText ]
        , Attributes.class "order-line__total-price"
        ]
        [ Html.text <| formatPrice <| applyDiscount discount <| toFloat quantity * unitPrice ]


viewBottomLine : Int -> Float -> Discount -> Html msg
viewBottomLine quantity unitPrice discount =
    div
        [ styles [ Css.property "justify-self" "flex-end" ]
        , Attributes.class "order-line__bottom-line"
        ]
        [ Html.text " x "
        , span
            [ styles [ mixins.boldText ] ]
            [ Html.text <| toString quantity ]
        , Html.text " = "
        , viewTotalPrice quantity unitPrice discount
        ]


viewInfo : Int -> Float -> Discount -> Html msg
viewInfo quantity unitPrice discount =
    div
        [ Attributes.class "order-line__info order-line__row" ]
        [ viewDiscount discount
        , viewBottomLine quantity unitPrice discount
        ]


view : (OrderLineId -> msg) -> Bool -> ( OrderLine, Product ) -> Html msg
view handleClick isSelected ( orderLine, product ) =
    let
        id =
            orderLine |> OrderLine.toId

        name =
            product |> Product.toName

        price =
            product |> Product.toPrice

        quantity =
            orderLine |> OrderLine.toQuantity

        discount =
            orderLine |> OrderLine.toDiscount
    in
    div
        [ styles
            [ if isSelected then
                mixin
                    [ backgroundColor Colors.accentBg
                    , color Colors.secondaryText
                    ]
              else
                mixin []
            , Css.property "display" "grid"
            , Css.property "grid-template-rows" "1fr 1fr"
            , Css.property "grid-template-columns" "1fr auto"
            , Css.property "grid-gap" "5px"
            , minHeight (px 50)
            , padding (px 5)
            , alignItems center
            , borderBottom3 (px 1) solid Colors.secondaryBg
            , cursor pointer
            ]
        , Attributes.class "order-line"
        , onClick <| handleClick id
        ]
        [ viewName name
        , viewUnitPrice price discount
        , viewDiscount discount
        , viewBottomLine quantity price discount
        ]
