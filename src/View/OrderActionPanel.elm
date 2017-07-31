module View.OrderActionPanel exposing (view)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import SelectList
import View.Breadcrumb as Breadcrumb
import View.Colors as Colors
import View.Numpad as Numpad
import View.Utils exposing (styles)


view : Html msg
view =
    let
        renderButton : String -> String -> Html msg
        renderButton text gridArea =
            div
                [ styles
                    [ Css.property "grid-area" gridArea
                    , Css.property "display" "grid"
                    , Css.property "align-content" "center"
                    , Css.property "justify-content" "center"
                    , backgroundColor Colors.secondaryBg
                    , borderRadius (px 5)
                    , fontWeight bold
                    ]
                ]
                [ Html.text text ]

        viewNavigation =
            div
                [ styles
                    [ Css.property "display" "grid"
                    , Css.property "grid-area" "navigation"
                    , Css.property "grid-template-rows" "repeat(4, 1fr)"
                    , Css.property "grid-template-areas" "'next' 'next' '.' 'cancel'"
                    ]
                ]
                [ renderButton "Next" "next"
                , renderButton "Cancel" "cancel"
                ]

        viewRightActions =
            div
                [ styles
                    [ Css.property "display" "grid"
                    , Css.property "gridArea" "action-right"
                    , Css.property "grid-template-rows" "repeat(4, 1fr)"
                    , Css.property "grid-template-columns" "1fr 1fr"
                    , Css.property "grid-template-areas" "'minus plus' '. .' '. .' 'delete delete'"
                    ]
                , Attributes.class "order-action-panel__right-actions"
                ]
                [ renderButton "-" "minus"
                , renderButton "+" "plus"
                , renderButton "Delete" "delete"
                ]
    in
    div
        [ styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "50px 200px"
            , Css.property "grid-template-columns" "2fr 1fr 1fr"
            , Css.property "grid-template-areas" "'breadcrumb breadcrumb breadcrumb' 'action-left action-right navigation'"
            , Css.property "grid-column-gap" "10px"
            , backgroundColor Colors.mainBg
            , padding (px 10)
            ]
        , Attributes.class "order-action-panel"
        ]
        [ Breadcrumb.view (SelectList.fromLists [ "Edit" ] "Method" [ "Payment" ])
        , viewNavigation
        , viewRightActions
        , Numpad.view
        ]
