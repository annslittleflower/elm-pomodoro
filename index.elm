--module Pomodoro exposing (..)
import Html exposing (Html, button, div, text, program, p)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Time exposing (Time, second)


type alias Model = {
  text: String,
  timeToRest: Int,
  countOfPomodoro: Int,
  timeToWork: Int,
  isButtonDisabled: Bool,
  timerCount: Int,
  isRestingNow: Bool,
  timerStarted: Bool,
  isWorking: Bool,
  restingTimerCount: Int
}

type Msg
    = Expand
    | Disable | NoOp | Tick Time

init : ( Model, Cmd Msg )
init = ( {
  text = "Please press Start Work when you ready",
  timeToRest = 10,
  countOfPomodoro = 0,
  timeToWork = 3,
  isButtonDisabled = False,
  timerCount = 0,
  isRestingNow = False,
  timerStarted = False,
  isWorking = False,
  restingTimerCount = 0
  }
  ,
  Cmd.none )


view : Model -> Html Msg
view model =
    if model.isButtonDisabled == False || model.isRestingNow == True then
        div []
            [
              button [ onClick Disable, disabled (model.timeToRest - model.restingTimerCount < 10) ] [ text "Start work" ],
              p [] [text model.text]
            ]
    else
        div []
            [
              button [ onClick Expand, disabled model.isButtonDisabled ] [ text "Working..." ],
              p [] [text ("Time left to work: "
                ++ (toString (model.timeToWork - model.timerCount)))

                ]
            ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Expand ->
            ( model, Cmd.none )
        Disable ->
            ( {model | isButtonDisabled = True, isWorking = True, isRestingNow = False, timerCount = 0, timerStarted = True, timeToRest = 10}, Cmd.none )
        Tick newTime ->

            let isRestingNow = model.isRestingNow
            in



            let incrementedTimerWorking = if(isRestingNow == False && model.timeToWork - model.timerCount > 0) then model.timerCount + 1 else 0
            in
            let incrementedRestingTimer = if(isRestingNow == True && model.timeToRest - model.restingTimerCount > 0) then model.restingTimerCount + 1 else 0
            in



            let countOfPomodoroNew = if model.timeToWork - incrementedTimerWorking == 0
            then
            model.countOfPomodoro + 1 else model.countOfPomodoro
            in



            let isRestingNowNew = if ((model.countOfPomodoro) % 4 == 0  &&  incrementedTimerWorking == 0  )
                    then
                      True
                    else False
            in



             let shouldStopTimer = if (( isRestingNowNew == False && model.timeToWork - model.timerCount == 0) || (isRestingNowNew == True && model.timeToRest - model.restingTimerCount == 0)) then False else True
             in



             let isStopWorking = if (model.timeToWork - model.timerCount == 0 && isRestingNow == False) then False else True
             in




            let willButtonBeDisabled = if isStopWorking == True || isRestingNowNew == True || incrementedTimerWorking /= 0 then
                  True else False
            in

            ({
              model
                | timerCount = incrementedTimerWorking ,
                  countOfPomodoro = countOfPomodoroNew,
                  isButtonDisabled = willButtonBeDisabled,
                  text =
                  if isRestingNowNew == True && (model.timeToRest - model.restingTimerCount > 0)
                  then
                  "Rest now for " ++ toString(model.timeToRest - model.restingTimerCount) ++ " seconds"
                  else "Please press Start Work when you ready",
                  isRestingNow = isRestingNowNew,
                  timerStarted = shouldStopTimer,
                  isWorking = isStopWorking,
                  restingTimerCount = incrementedRestingTimer

            }, Cmd.none )




subscriptions : Model -> Sub Msg
subscriptions model =
    if model.timerStarted == True
    then Time.every second Tick else Sub.none



main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
