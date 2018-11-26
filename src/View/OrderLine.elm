module View.OrderLine exposing (view)

import Css exposing (..)
import Data.OrderLine as OrderLine exposing (OrderLine, OrderLineId)
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


viewUnitPrice : Float  -> Html msg
viewUnitPrice price  =
    div
        [ styles [ mixins.boldText, Css.property "justify-self" "flex-end" ]
        , Attributes.class "order-line__unit-price"
        ]
        [ span [ Attributes.class "order-line__unit-price--old"
                    , styles
                        [ textDecoration lineThrough
                        , fontSize (Css.em 0.8)
                        , fontWeight normal
                        ]
                    ] [ Html.text <| formatPrice price ]
        , Html.text " "
        ]




viewTotalPrice : Int -> Float -> Html msg
viewTotalPrice quantity unitPrice  =
    span
        [ styles [ mixins.boldText ]
        , Attributes.class "order-line__total-price"
        ]
        [ Html.text <| formatPrice  <| toFloat quantity * unitPrice ]


viewBottomLine : Int -> Float -> Html msg
viewBottomLine quantity unitPrice  =
    div
        [ styles [ Css.property "justify-self" "flex-end" ]
        , Attributes.class "order-line__bottom-line"
        ]
        [ Html.text " x "
        , span
            [ styles [ mixins.boldText ] ]
            [ Html.text <| toString quantity ]
        , Html.text " = "
        , viewTotalPrice quantity unitPrice 
        ]


viewInfo : Int -> Float  -> Html msg
viewInfo quantity unitPrice  =
    div
        [ Attributes.class "order-line__info order-line__row" ]
        [  viewBottomLine quantity unitPrice 
        ]


view : (OrderLineId -> msg) -> Bool -> OrderLine -> Html msg
view handleClick isSelected orderLine =
    let
        id =
            orderLine |> OrderLine.toId

        name =
            orderLine |> OrderLine.toProductName

        price =
            orderLine |> OrderLine.toProductPrice

        quantity =
            orderLine |> OrderLine.toQuantity

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
        , viewUnitPrice price
        , viewBottomLine quantity price 
        ]
