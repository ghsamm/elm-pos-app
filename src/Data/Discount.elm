module Data.Discount exposing (..)


type Discount
    = NoDiscount
    | AmountDiscount Float
    | PercentageDiscount Float


discountToString : Discount -> String
discountToString discount =
    case discount of
        NoDiscount ->
            ""

        AmountDiscount amt ->
            toString amt ++ " DT"

        PercentageDiscount pct ->
            toString pct ++ "%"


applyDiscount : Discount -> Float -> Float
applyDiscount discount price =
    case discount of
        NoDiscount ->
            price

        AmountDiscount amt ->
            price - amt

        PercentageDiscount pct ->
            price * (100 - pct) / 100
