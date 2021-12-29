module View.OrderLine exposing (view)

import Css exposing (..)
import Data.OrderLine as OrderLine exposing (OrderLine, OrderLineId)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (class, classList, css)
import Html.Styled.Events exposing (..)
import Util exposing (formatPrice)
import View.Colors as Colors


viewName : String -> Html msg
viewName name =
    div [ Attributes.class "order-line__product-name" ]
        [ text <| name ]


viewUnitPrice : Float -> Html msg
viewUnitPrice price =
    div
        [ css [ fontWeight bold, Css.property "justify-self" "flex-end" ]
        , Attributes.class "order-line__unit-price"
        ]
        [ span
            [ Attributes.class "order-line__unit-price--old"
            , css
                [ textDecoration lineThrough
                , fontSize (Css.em 0.8)
                , fontWeight normal
                ]
            ]
            [ text <| formatPrice price ]
        , text " "
        ]


viewTotalPrice : Int -> Float -> Html msg
viewTotalPrice quantity unitPrice =
    span
        [ css [ fontWeight bold ]
        , Attributes.class "order-line__total-price"
        ]
        [ text <| formatPrice <| toFloat quantity * unitPrice ]


viewBottomLine : Int -> Float -> Html msg
viewBottomLine quantity unitPrice =
    div
        [ css [ Css.property "justify-self" "flex-end" ]
        , Attributes.class "order-line__bottom-line"
        ]
        [ text " x "
        , span
            [ css [ fontWeight bold ] ]
            [ text <| String.fromInt quantity ]
        , text " = "
        , viewTotalPrice quantity unitPrice
        ]


viewInfo : Int -> Float -> Html msg
viewInfo quantity unitPrice =
    div
        [ Attributes.class "order-line__info order-line__row" ]
        [ viewBottomLine quantity unitPrice
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

        selectedStyle =
            if isSelected then
                [ backgroundColor Colors.accentBg
                , color Colors.secondaryText
                ]

            else
                []
    in
    div
        [ css
            (List.append selectedStyle
                [ Css.property "display" "grid"
                , Css.property "grid-template-rows" "1fr 1fr"
                , Css.property "grid-template-columns" "1fr auto"
                , Css.property "grid-gap" "5px"
                , minHeight (px 50)
                , padding (px 5)
                , alignItems center
                , borderBottom3 (px 1) solid Colors.secondaryBg
                , cursor pointer
                ]
            )
        , Attributes.class "order-line"
        , onClick <| handleClick id
        ]
        [ viewName name
        , viewUnitPrice price
        , viewBottomLine quantity price
        ]
