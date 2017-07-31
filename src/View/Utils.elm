module View.Utils exposing (styles)

import Css exposing (Mixin)
import Html exposing (Attribute)
import Html.Attributes as Attributes


styles : List Mixin -> Attribute msg
styles =
    Css.asPairs >> Attributes.style
