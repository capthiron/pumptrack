module Main exposing (..)

import Browser
import FeatherIcons
import Html exposing (Html, div, h1, i, img, main_, span, text)
import Html.Attributes exposing (attribute, class, id, src)
import Html exposing (progress)



---- MODEL ----


type alias Model =
    { progress : Progress
    }


type alias Progress =
    { done : Int
    , total : Int
    }


initialModel : { progress : { done : number, total : number } }
initialModel =
    { progress =
        { done = 75
        , total = 100
        }
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    main_ []
        [ viewMenu
        , viewContent model
        ]


viewMenu : Html msg
viewMenu =
    div [ id "menu" ]
        [ span [ class "menu-buttons" ]
            [ viewMenuButton "info" FeatherIcons.info ]
        , span [ class "menu-buttons" ]
            [ viewMenuButton "stats" FeatherIcons.activity
            , viewMenuButton "leaderboard" FeatherIcons.award
            , viewMenuButton "settings" FeatherIcons.settings
            ]
        ]


viewMenuButton : String -> FeatherIcons.Icon -> Html msg
viewMenuButton name icon =
    icon
        |> FeatherIcons.toHtml [ id name ]


viewContent : Model -> Html msg
viewContent model =
    div [ class "content" ]
        [ viewProgressCircle model.progress
        ]


viewProgressCircle : Progress -> Html msg
viewProgressCircle progress =
    div [ class "progress-circle" ]
        [ viewProgress progress
        ]


viewPushToStart : Html msg
viewPushToStart =
    div [ class "push-to-start" ]
        [ span [ class "push" ] [ text "Push" ]
        , viewAbsoluteProgress 0 100
        ]


viewProgress : Progress -> Html msg
viewProgress progress =
    div [ class "progress" ]
        [ viewRelativeProgress (calcPercentage progress.done progress.total)
        , viewAbsoluteProgress progress.done progress.total
        ]


viewRelativeProgress : Int -> Html msg
viewRelativeProgress value =
    div [ class "relative-progress" ]
        [ span [ class "relative-progress-value" ] [ text (String.fromInt value) ]
        , span [ class "relative-progress-percent-sign" ] [ text "%" ]
        ]


calcPercentage : Int -> Int -> Int
calcPercentage part whole = floor ((toFloat part / toFloat whole) * 100)


viewAbsoluteProgress : Int -> Int -> Html msg
viewAbsoluteProgress done total =
    span [ class "absolute-progress" ] [ text (String.fromInt done ++ "/" ++ String.fromInt total) ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
