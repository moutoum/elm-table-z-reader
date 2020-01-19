module ZTable exposing (..)

import List exposing (filter, head, length)
import List.Extra exposing (find, getAt, minimumWith, takeWhile)
import Tuple exposing (first, second)


type alias ZTable =
    List ( Float, Float )


findp : Float -> ZTable -> Maybe Float
findp z table =
    table
        |> find (first >> (==) z)
        |> Maybe.andThen (Just << second)


findz : Float -> ZTable -> Maybe Float
findz p table =
    let
        deltaTable : List ( Float, Float )
        deltaTable =
            List.map (Tuple.mapSecond (absDelta p)) table

        minimumDelta : Maybe ( Float, Float )
        minimumDelta =
            minimumWith (\( _, deltaA ) ( _, deltaB ) -> compare deltaA deltaB) deltaTable
    in
    minimumDelta
        |> Maybe.andThen (second >> (\v -> filterWithValue v deltaTable) >> selectBetterEntry)
        |> Maybe.andThen (Just << first)


selectBetterEntry : List ( Float, Float ) -> Maybe ( Float, Float )
selectBetterEntry l =
    getAt ((length l - 1) // 2) l


filterWithValue : Float -> List ( Float, Float ) -> List ( Float, Float )
filterWithValue v =
    filter (second >> (==) v)


absDelta : number -> number -> number
absDelta a b =
    abs (a - b)
