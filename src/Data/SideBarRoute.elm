module Data.SideBarRoute exposing (..)


type SideBarRoute
    = EditCurrentOrder
    | ViewingHistory


toggle : SideBarRoute -> SideBarRoute
toggle route =
    case route of
        EditCurrentOrder ->
            ViewingHistory

        ViewingHistory ->
            EditCurrentOrder
