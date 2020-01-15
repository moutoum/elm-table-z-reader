module Utils exposing (..)


tuple2 : List a -> Maybe ( a, a )
tuple2 list =
    case list of
        [ a, b ] ->
            Just <| Tuple.pair a b

        _ ->
            Nothing


convertTuple2StringToTuple2Float : ( String, String ) -> Maybe ( Float, Float )
convertTuple2StringToTuple2Float ( a, b ) =
    let
        parsedA =
            String.toFloat a

        parsedB =
            String.toFloat b
    in
    case ( parsedA, parsedB ) of
        ( Just floatA, Just floatB ) ->
            Just <| Tuple.pair floatA floatB

        _ ->
            Nothing
