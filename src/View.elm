module View exposing (..)

import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Browser exposing (Document)
import Html exposing (Html, h1, text)
import Html.Attributes exposing (class, style, value)
import Model exposing (Model, Msg(..))


view : Model -> Document Msg
view model =
    Document "Table Z"
        [ Grid.container []
            [ CDN.stylesheet
            , Grid.row [ Row.centerXs ]
                [ Grid.col [ Col.xsAuto ] [ h1 [] [ text "Lecteur de table Z" ] ] ]
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
                        [ text "Charger une table Z au format CSV (.csv)" ]
                    ]
                ]

        Just _ ->
            Grid.row [ Row.centerXs ]
                [ Grid.col [ Col.xs9 ]
                    [ Form.form []
                        [ Form.row []
                            [ Form.col [ Col.xs6 ] [ Input.text [ Input.placeholder "Valeur à rechercher", Input.onInput OnContentChanged, Input.value model.content ] ]
                            , Form.col [ Col.xs3 ] [ Button.button [ Button.primary, Button.onClick SearchPValue, Button.block ] [ text "Rechercher P" ] ]
                            , Form.col [ Col.xs3 ] [ Button.button [ Button.primary, Button.onClick SearchZValue, Button.block ] [ text "Rechercher Z" ] ]
                            ]
                        ]
                    , searchedValueView model.searchedValue
                    ]
                ]


searchedValueView : Maybe Float -> Html Msg
searchedValueView value =
    case value of
        Just x ->
            h1 [ style "text-align" "center", style "font-size" "90px" ] [ text (String.fromFloat x) ]

        Nothing ->
            text ""
