module Main exposing (..)

import Browser
import FeatherIcons
import Html exposing (Html, div, h1, i, img, main_, span, text)
import Html.Attributes exposing (attribute, class, id, src)



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



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
        , viewContent
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


viewContent : Html msg
viewContent =
    div [ class "content" ]
        [ viewProgressCircle
        ]


viewProgressCircle : Html msg
viewProgressCircle =
    div [ class "progress-circle" ]
        [ viewPushToStart
        ]


viewPushToStart : Html msg
viewPushToStart =
    div [ class "push-to-start" ]
        [ text "Push"
        , text "0/100"
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
