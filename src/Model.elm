module Model exposing (..)

import File exposing (File)
import ZTable exposing (ZTable)


type alias Model =
    { ztable : Maybe ZTable
    , content : String
    , searchedValue : Maybe Float
    }


type Msg
    = CsvRequested
    | CsvSelected File
    | CsvLoaded String
    | OnContentChanged String
    | SearchPValue


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Nothing "" Nothing, Cmd.none )
