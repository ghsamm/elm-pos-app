module Data.SideBarRoute exposing (..)


type SideBarRoute
    = EditCurrentOrder
    | ViewHistory


toggle : SideBarRoute -> SideBarRoute
toggle route =
    case route of
        EditCurrentOrder ->
            ViewHistory

        ViewHistory ->
            EditCurrentOrder
