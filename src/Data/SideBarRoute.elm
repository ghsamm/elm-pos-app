module Data.SideBarRoute exposing (..)


type ViewHistorySubRoute
    = CurrentOrders
    | DailyHistory


type SideBarRoute
    = EditCurrentOrder
    | ViewHistory ViewHistorySubRoute


toggle : SideBarRoute -> SideBarRoute
toggle route =
    case route of
        EditCurrentOrder ->
            ViewHistory CurrentOrders

        ViewHistory _ ->
            EditCurrentOrder
