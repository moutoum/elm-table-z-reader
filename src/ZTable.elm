module ZTable exposing (..)

import List.Extra exposing (find)


type alias ZTable =
    List ( Float, Float )


findp : Float -> ZTable -> Maybe Float
findp z table =
    table
        |> find (Tuple.first >> (==) z)
        |> Maybe.andThen (Just << Tuple.second)


findz : Float -> ZTable -> Maybe Float
findz p table =
    table
        |> find (Tuple.second >> (==) p)
        |> Maybe.andThen (Just << Tuple.first)
