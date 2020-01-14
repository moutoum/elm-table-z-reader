module Main exposing (main)

import Array
import Browser
import Csv exposing (Csv, parse)
import File exposing (File)
import File.Select as Select exposing (file)
import Html exposing (Html, button, div, p, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Task

main =
  Browser.element
  { init = init
  , update = update
  , view = view
  , subscriptions = subscriptions
  }

type alias Model =
    { content : Maybe Csv
    }

init : () -> (Model, Cmd Msg)
init _ =
    ( Model Nothing, Cmd.none )

type Msg = CsvRequested
         | CsvSelected File
         | CsvLoaded String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    CsvRequested ->
        ( model
        , Select.file ["text/csv"] CsvSelected
        )

    CsvSelected file ->
         ( model
         , Task.perform CsvLoaded (File.toString file)
         )

    CsvLoaded content ->
        ( { model | content = Just <| parse content }
        , Cmd.none
        )

view : Model -> Html Msg
view model =
  case model.content of
    Nothing ->
      button [ onClick CsvRequested ] [ text "Load CSV" ]

    Just csv ->
        table []
        [ thead [] <| List.map (\header -> th [] [ text header ]) csv.headers
        , tbody [] <| List.map (\row -> tr [] (List.map (\data -> td [] [ text data ]) row)) csv.records
        ]

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none