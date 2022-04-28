port module Main exposing (..)

import Browser
import FeatherIcons
import Html exposing (Html, div, h1, i, img, main_, progress, span, text)
import Html.Attributes exposing (attribute, class, id, src)
import Html.Events exposing (onClick)



---- MODEL ----


type alias Model =
    { progress : Progress
    }


type alias Progress =
    { done : Int
    , total : Int
    , steps : Int
    }


initialModel : Model
initialModel =
    { progress =
        { done = 0
        , total = 495
        , steps = 20
        }
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = ProgressCirclePressed
    | ProgressCircleChanged Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ProgressCirclePressed ->
            ( model, updateProgressCircle model.progress )

        ProgressCircleChanged updatedDone ->
            let
                currentProgress =
                    model.progress

                updatedProgress =
                    { currentProgress
                        | done = updatedDone
                    }
            in
            ( { model | progress = updatedProgress }, Cmd.none )



---- Subscriptions ----


subscriptions : Model -> Sub Msg
subscriptions model =
    onProgressChange ProgressCircleChanged



---- Ports ----


port updateProgressCircle : Progress -> Cmd msg


port onProgressChange : (Int -> msg) -> Sub msg



-- ( model, Cmd.none )
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


viewContent : Model -> Html Msg
viewContent model =
    div [ class "content" ]
        [ viewProgressCircle model.progress
        ]


viewProgressCircle : Progress -> Html Msg
viewProgressCircle progress =
    div [ class "progress-circle", onClick ProgressCirclePressed ]
        [ if progress.done > 0 then
            viewProgress progress

          else
            viewPushToStart
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
calcPercentage part whole =
    floor ((toFloat part / toFloat whole) * 100)


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
        , subscriptions = subscriptions 
        }
