module View.OrderHistory exposing (..)

import Css exposing (..)
import Data.Model exposing (Model)
import Data.Msg exposing (Msg)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (styles)
import View.Colors as Colors


view : Model -> Html Msg
view model =
    div
        [ Attributes.class "order-history"
        , styles
            [ backgroundColor Colors.mainBg
            ]
        ]
        []
