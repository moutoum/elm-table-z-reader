module Model exposing (..)

import File exposing (File)


type alias Model =
    { ztable : Maybe ZTable
    }


type Msg
    = CsvRequested
    | CsvSelected File
    | CsvLoaded String


type alias ZTable =
    List ( Float, Float )


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Nothing, Cmd.none )
