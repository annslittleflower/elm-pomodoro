module Pomodoro exposing (..)

import Html exposing (Html, button, div, text, program)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
-- import Html.App exposing (beginnerProgram)
{-
  What we should do:
    1. One pomodoro - 25 min (1500 sec)
    2. Break - 5 min (300 sec)
    3. After 4 pomodoro in a row - break 20 min (1200 sec)

  Algorithm:
    1. Render button "start timer"
    2. When user presses button - disable it
    3. Show text "please do your job ${timeToWork} minutes more"
    4. If timeToWork === 0, increment pomodoroCounter + 1
    5. If (pomodoroCounter % 4 === 0) breakTime 1200 sec, else 300 sec
    6. If breakTime > 0, show text "please rest ${breakTime} seconds more"
    7. Updating ${breakTime} on the screen
    8. If breakTime === 0, make "start timer" clickable again
-}

type alias Model = { text: String}

type Msg
    = Expand
    | Collapse | NoOp

init : ( Model, Cmd Msg )
init = ( {text = ""}, Cmd.none )

{-

        div []
            [ button [ onClick Collapse ] [ text "Collapse" ]
            , text "Widget"
            ]








            update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Expand ->
            ( True, Cmd.none )

        Collapse ->
            ( False, Cmd.none )
-}

--Collapse : Int -> Int

setText : String -> Model -> Model
setText newText model =
    let
        a =
            model.text
    in
        { model | text = newText }

view : Model -> Html Msg
view model =
    if model.text == "" then
        div []
            [
              button [ onClick Collapse ] [ text "Collapse" ]
            ]
    else
        div []
            [ button [ onClick Expand ] [ text "Expand" ] ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        Expand ->
            ( model, Cmd.none )
        Collapse ->
            let
                newText =
                    "clicked"
            ( setText newText model, Cmd.none )





subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
