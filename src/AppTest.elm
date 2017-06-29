module AppTest exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import SelectList exposing (SelectList)
import View.Breadcrumb as Breadcrumb


names : SelectList String
names =
    SelectList.fromLists [] "Edit" [ "Method", "Payment" ]


main : Html msg
main =
    div [ class "breadcrumb__container" ]
        [ Breadcrumb.view names
        ]
