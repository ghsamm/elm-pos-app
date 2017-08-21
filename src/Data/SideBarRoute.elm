module Data.SideBarRoute exposing (..)


type SideBarRoute
    = EditingOrder
    | ViewingHistory


toggle : SideBarRoute -> SideBarRoute
toggle route =
    case route of
        EditingOrder ->
            ViewingHistory

        ViewingHistory ->
            EditingOrder
