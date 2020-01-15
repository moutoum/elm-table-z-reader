module View exposing (..)

import Html exposing (Html, button, table, tbody, td, text, th, thead, tr)
import Html.Events exposing (onClick)
import Model exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    case model.ztable of
        Nothing ->
            button [ onClick CsvRequested ] [ text "Load CSV" ]

        Just values ->
            table []
                [ thead [] <| List.map (\header -> th [] [ text header ]) [ "Z", "P" ]
                , tbody [] <| List.map recordView values
                ]


recordView : ( Float, Float ) -> Html Msg
recordView ( a, b ) =
    tr [] <| List.map dataView [ String.fromFloat a, String.fromFloat b ]


dataView : String -> Html Msg
dataView str =
    str
        |> text
        |> List.singleton
        |> td []
