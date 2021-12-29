module Util exposing (..)

-- import Css exposing (Mixin)

import Dict exposing (Dict)
import Round



-- import Html.Attributes as Attributes
-- (=>) : a -> b -> ( a, b )
-- (=>) =
--     (,)


{-| infixl 0 means the (=>) operator has the same precedence as (<|) and (|>),
meaning you can use it at the end of a pipeline and have the precedence work out.
-}



-- infixl 0 =>
-- styles : List Mixin -> Attribute msg
-- styles =
--     Css.asPairs >> Attributes.style


formatPrice : Float -> String
formatPrice price =
    Round.round 3 price ++ " DT"


listToDict : (v -> comparable) -> List v -> Dict comparable v
listToDict keyGetter list =
    list
        |> List.map (\el -> ( keyGetter el, el ))
        |> Dict.fromList


isJust : Maybe a -> Bool
isJust maybe =
    case maybe of
        Just _ ->
            True

        Nothing ->
            False
