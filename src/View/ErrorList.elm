module View.ErrorList exposing (..)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)


viewError : String -> Html msg
viewError errorText =
    div
        [ css
            [ Css.width (px 500)
            , backgroundColor (hex "fff")
            , color (hex "e64141")
            , border3 (px 1) solid (hex "e64141")
            , padding (px 20)
            , margin (px 5)
            , Css.property "animation-name" "slide-fade-in-to-left"
            , Css.property "animation-duration" "300ms"
            ]
        , Attributes.class "error"
        ]
        [ text errorText ]


view : List String -> Html msg
view errorList =
    div
        [ css
            [ position absolute
            , top zero
            , right zero
            , marginTop (px 20)
            , overflow Css.hidden
            ]
        , Attributes.class "error-list"
        ]
    <|
        List.map viewError errorList
