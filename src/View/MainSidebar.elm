module View.MainSidebar exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLine as OrderLine
import Dict
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import SelectList
import Selector.OrderLine exposing (orderLinePrice)
import Util exposing (formatPrice)
import View.Breadcrumb as Breadcrumb
import View.Numpad as Numpad
import View.OrderLineList as OrderLineList


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style


getTotal : Model -> Float
getTotal store =
    let
        lineTotals =
            Dict.values <|
                Dict.map
                    (\str orderLine ->
                        orderLinePrice (orderLine |> OrderLine.toId) store
                    )
                    store.orderLines
    in
    List.foldl (+) 0 lineTotals


viewTotal : Model -> Html Msg
viewTotal store =
    div
        [ Attributes.class "order-lines-total"
        , styles
            [ Css.property "display" "grid"
            , fontSize (Css.em 1.2)
            , Css.property "justify-self" "stretch"
            , Css.property "align-self" "center"
            , textAlign right
            , borderTop3 (px 2) solid (hex "000")
            , padding2 (px 5) (px 10)
            ]
        ]
        [ Html.text "TOTAL : "
        , Html.text <| formatPrice <| getTotal <| store
        ]


viewOrderActionPanel : Model -> Html Msg
viewOrderActionPanel model =
    let
        renderButton : String -> String -> Html Msg
        renderButton text gridArea =
            div
                [ styles
                    [ Css.property "grid-area" gridArea
                    , Css.property "display" "grid"
                    , Css.property "align-content" "center"
                    , Css.property "justify-content" "center"
                    , border3 (px 2) solid (hex "bbb")
                    , color (hex "bbb")
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
            , margin (px 10)
            ]
        , Attributes.class "order-action-panel"
        ]
        [ Breadcrumb.view (SelectList.fromLists [ "Edit" ] "Method" [ "Payment" ])
        , viewNavigation
        , viewRightActions
        , Numpad.view
        ]


view : Model -> Html Msg
view store =
    div
        [ Attributes.class "main-sidebar"
        , styles
            [ Css.property "display" "grid"
            , borderRight3 (px 2) solid (hex "eee")
            , Css.property "grid-template-rows" "1fr 40px auto"
            , overflowY Css.hidden
            ]
        ]
        [ OrderLineList.view store.orderLines store
        , viewTotal store
        , viewOrderActionPanel store
        ]
