module View.MainSidebar exposing (view)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (..)
import Data.OrderLineStore as OrderLineStore exposing (OrderLineStoreMsg(..))
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (formatPrice, styles)
import View.Order as OrderLineListContainer
import View.OrderActionPanel as OrderActionPanel


view : Model -> Html Msg
view model =
    div
        [ Attributes.class "main-sidebar"
        , styles
            [ Css.property "display" "grid"
            , Css.property "grid-template-rows" "1fr 220px"
            , Css.property "grid-row-gap" "10px"
            , overflowY Css.hidden
            ]
        ]
        [ OrderLineListContainer.view model
        , OrderActionPanel.view model
            { onNumpadClick = OrderLineStoreMsg << SetCurrentOrderLineQuantity
            , onDecrement = OrderLineStoreMsg DecrementCurrentOrderLineQunatity
            , onIncrement = OrderLineStoreMsg IncrementCurrentOrderLineQunatity
            , onDelete = OrderLineStoreMsg DeleteCurrentOrderLine
            }
        ]
