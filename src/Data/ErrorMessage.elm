module Data.ErrorMessage exposing (..)


type alias ErrorMessageProps msg =
    { text : String
    , action : Maybe msg
    }


type ErrorMessage msg
    = ErrorMessage (ErrorMessageProps msg)


fromText : String -> ErrorMessage msg
fromText text =
    ErrorMessage
        { text = text
        , action = Nothing
        }


toText : ErrorMessage msg -> String
toText (ErrorMessage errorMessage) =
    errorMessage.text


toAction : ErrorMessage msg -> Maybe msg
toAction (ErrorMessage errorMessage) =
    errorMessage.action
