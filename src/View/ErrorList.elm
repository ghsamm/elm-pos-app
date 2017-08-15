module View.ErrorList exposing (..)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Util exposing (styles)


viewError : String -> Html msg
viewError errorText =
    div
        [ styles
            [ Css.width (px 500)
            , backgroundColor (hex "fff")
            , color (hex "e64141")
            , border3 (px 1) solid (hex "e64141")
            , padding (px 20)
            , margin (px 5)
            ]
        , Attributes.class "error"
        ]
        [ Html.text errorText ]


view : List String -> Html msg
view errorList =
    div
        [ styles
            [ position absolute
            , top zero
            , right zero
            , marginTop (px 20)
            ]
        , Attributes.class "error-list"
        ]
    <|
        List.map viewError errorList
