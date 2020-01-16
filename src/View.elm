module View exposing (..)

import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup exposing (Input)
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Browser exposing (Document)
import Html exposing (Html, button, div, h1, input, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class, placeholder, style, type_, value)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Msg(..))


view : Model -> Document Msg
view model =
    Document "Table Z"
        [ Grid.container []
            [ CDN.stylesheet
            , Grid.row [ Row.centerXs ]
                [ Grid.col [ Col.xsAuto ] [ h1 [] [ text "Statistic table Z reader" ] ] ]
            , mainPage model
            ]
        ]


mainPage : Model -> Html Msg
mainPage model =
    case model.ztable of
        Nothing ->
            Grid.row [ Row.centerXs ]
                [ Grid.col [ Col.xs4 ]
                    [ Button.button
                        [ Button.onClick CsvRequested, Button.primary, Button.block, Button.attrs [ class "my-4" ] ]
                        [ text "Load CSV" ]
                    ]
                ]

        Just values ->
            Grid.row [ Row.centerXs ]
                [ Grid.col [ Col.xs9 ]
                    [ Form.form []
                        [ Form.row []
                            [ Form.col [ Col.xs9 ] [ Input.text [ Input.placeholder "P value", Input.onInput OnContentChanged ] ]
                            , Form.col [ Col.xs3 ] [ Button.button [ Button.primary, Button.onClick SearchPValue, Button.block ] [ text "Search" ] ]
                            ]
                        ]
                    , searchedValueView model.searchedValue
                    ]
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
            h1 [ style "text-align" "center", style "font-size" "90px" ] [ text (String.fromFloat x) ]

        Nothing ->
            text ""
