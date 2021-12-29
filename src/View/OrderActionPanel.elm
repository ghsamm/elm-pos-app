module View.OrderActionPanel exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.OrderLine as OrderLine
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Intl exposing (intl)
import Selector.OrderLine as OrderLineSelector exposing (orderLineSelector)
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


buttonAttributes : String -> List (Attribute msg)
buttonAttributes gridArea =
    [ css
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
renderButton buttonText gridArea =
    a
        (buttonAttributes gridArea)
        [ text buttonText ]


renderButtonWithListener : String -> String -> msg -> Html msg
renderButtonWithListener buttonText gridArea handleClick =
    a
        (List.append
            (buttonAttributes gridArea)
            [ onClick handleClick ]
        )
        [ text buttonText ]


viewNavigation : Html msg
viewNavigation =
    div
        [ css
            [ Css.property "display" "grid"
            , Css.property "grid-area" "navigation"
            , Css.property "grid-template-rows" "repeat(3, 1fr)"
            , Css.property "grid-template-areas" "'next' 'next' 'cancel'"
            , Css.property "grid-gap" "2px"
            ]
        , Attributes.class "order-action-panel__navigation"
        ]
        [ renderButton intl.save "next"
        , renderButton intl.cancel "cancel"
        ]


viewRightActions : ViewRightActionsListener msg -> Html msg
viewRightActions { onDecrement, onIncrement, onDelete } =
    div
        [ css
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
        , renderButtonWithListener intl.delete "delete" onDelete
        ]


view : Model -> ViewListeners msg -> Html msg
view model { onNumpadClick, onDecrement, onIncrement, onDelete } =
    div
        [ css
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "1fr"
            , Css.property "grid-template-columns" "2fr 1fr 1fr"
            , Css.property
                "grid-template-areas"
                "'action-left action-right navigation'"
            , Css.property "grid-gap" "10px"
            , backgroundColor Colors.mainBg
            , padding3 (px 10) (px 10) (px 20)
            ]
        , Attributes.class "order-action-panel"
        ]
        [ viewNavigation
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
