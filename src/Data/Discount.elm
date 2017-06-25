module Data.Discount exposing (..)


type Discount
    = AmountDiscount Float
    | PercentageDiscount Float


discountToString : Discount -> String
discountToString discount =
    case discount of
        AmountDiscount amt ->
            toString amt ++ " DT"

        PercentageDiscount amt ->
            toString amt ++ "%"
