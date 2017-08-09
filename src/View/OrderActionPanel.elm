module View.OrderActionPanel exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.OrderLine as OrderLine
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)
import SelectList
import Selector.OrderLine as OrderLineSelector exposing (orderLineSelector)
import Util exposing (styles)
import View.Breadcrumb as Breadcrumb
import View.Colors as Colors
import View.Numpad as Numpad


type alias ViewListeners msg =
    { onNumpadClick : Int -> msg
    , onDecrement : msg
    , onIncrement : msg
    , onDelete : msg
    }


type alias ViewRightActionsListener msg =
    { onDecrement : msg
    , onIncrement : msg
    , onDelete : msg
    }


buttonAttributs : String -> List (Attribute msg)
buttonAttributs gridArea =
    [ styles
        [ Css.property "grid-area" gridArea
        , Css.property "display" "grid"
        , Css.property "align-content" "center"
        , Css.property "justify-content" "center"
        , border zero
        , backgroundColor Colors.secondaryBg
        , fontWeight bold
        , padding (px 5)
        , textAlign center
        ]
    , Attributes.class "order-action-panel__button"
    , href "#"
    ]


renderButton : String -> String -> Html msg
renderButton text gridArea =
    a
        (buttonAttributs gridArea)
        [ Html.text text ]


renderButtonWithListener : String -> String -> msg -> Html msg
renderButtonWithListener text gridArea handleClick =
    a
        (List.append
            (buttonAttributs gridArea)
            [ onClick handleClick ]
        )
        [ Html.text text ]


viewNavigation : Html msg
viewNavigation =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-area" "navigation"
            , Css.property "grid-template-rows" "repeat(3, 1fr)"
            , Css.property "grid-template-areas" "'next' 'next' 'cancel'"
            , Css.property "grid-gap" "2px"
            ]
        ]
        [ renderButton "Next" "next"
        , renderButton "Cancel" "cancel"
        ]


viewRightActions : ViewRightActionsListener msg -> Html msg
viewRightActions { onDecrement, onIncrement, onDelete } =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "gridArea" "action-right"
            , Css.property "grid-template-rows" "repeat(3, 1fr)"
            , Css.property "grid-template-columns" "1fr 1fr"
            , Css.property "grid-template-areas" "'minus plus' '. .' 'delete delete'"
            , Css.property "grid-gap" "2px"
            ]
        , Attributes.class "order-action-panel__right-actions"
        ]
        [ renderButtonWithListener "-" "minus" onDecrement
        , renderButtonWithListener "+" "plus" onIncrement
        , renderButtonWithListener "Delete" "delete" onDelete
        ]


view : Model -> ViewListeners msg -> Html msg
view model { onNumpadClick, onDecrement, onIncrement, onDelete } =
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "50px 150px"
            , Css.property "grid-template-columns" "2fr 1fr 1fr"
            , Css.property "grid-template-areas" "'breadcrumb breadcrumb breadcrumb' 'action-left action-right navigation'"
            , Css.property "grid-column-gap" "10px"
            , backgroundColor Colors.mainBg
            , padding (px 10)
            , paddingBottom (px 20)
            ]
        , Attributes.class "order-action-panel"
        ]
        [ Breadcrumb.view (SelectList.fromLists [] "Edit" [ "Method", "Payment" ])
        , viewNavigation
        , viewRightActions
            { onDecrement = onDecrement
            , onIncrement = onIncrement
            , onDelete = onDelete
            }
        , Numpad.view
            (OrderLineSelector.selectedOrderLine model
                |> Maybe.map OrderLine.toQuantity
            )
            onNumpadClick
        ]
