module Update exposing (..)

import Csv exposing (parse)
import File
import File.Select
import Model exposing (Model, Msg(..))
import Task
import Utils exposing (convertTuple2StringToTuple2Float, tuple2)
import ZTable exposing (findp)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CsvRequested ->
            ( model
            , File.Select.file [ "text/csv" ] CsvSelected
            )

        CsvSelected file ->
            ( model
            , Task.perform CsvLoaded (File.toString file)
            )

        CsvLoaded content ->
            ( { model
                | ztable =
                    parse content
                        |> .records
                        |> List.filterMap tuple2
                        |> List.filterMap convertTuple2StringToTuple2Float
                        |> Just
              }
            , Cmd.none
            )

        OnContentChanged text ->
            ( { model | content = text }, Cmd.none )

        SearchPValue ->
            let
                number =
                    String.toFloat model.content

                searchedValue =
                    case ( number, model.ztable ) of
                        ( Just z, Just ztable ) ->
                            findp z ztable

                        _ ->
                            Nothing
            in
            ( { model
                | searchedValue = searchedValue
                , content = ""
              }
            , Cmd.none
            )
