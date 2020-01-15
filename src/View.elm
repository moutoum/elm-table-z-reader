module View exposing (..)

import Html exposing (Html, button, div, input, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (placeholder, type_, value)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    case model.ztable of
        Nothing ->
            button [ onClick CsvRequested ] [ text "Load CSV" ]

        Just values ->
            div []
                [ tableView values
                , input [ type_ "number", placeholder "P to search", value model.content, onInput OnContentChanged ] []
                , button [ onClick SearchPValue ] [ text "Search P value" ]
                , searchedValueView model.searchedValue
                ]


tableView : List ( Float, Float ) -> Html Msg
tableView values =
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


searchedValueView : Maybe Float -> Html Msg
searchedValueView value =
    case value of
        Just x ->
            text (String.fromFloat x)

        Nothing ->
            text ""
