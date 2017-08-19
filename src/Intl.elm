module Intl exposing (intl)


type alias Intl =
    { allCategories : String
    , cancel : String
    , delete : String
    , save : String
    , ticket : String
    , total : String
    }


intl : Intl
intl =
    english


english : Intl
english =
    { ticket = "TICKET"
    , total = "TOTAL"
    , save = "Save"
    , delete = "Delete"
    , cancel = "Cancel"
    , allCategories = "All Products"
    }


french : Intl
french =
    { ticket = "TICKET"
    , total = "TOTAL"
    , save = "Enreg."
    , delete = "Suppr."
    , cancel = "Annul."
    , allCategories = "Tous les produits"
    }
