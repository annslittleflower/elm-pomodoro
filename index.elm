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
  countOfPomodoro = 1,
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
    if model.isButtonDisabled == False then
        div []
            [
              button [ onClick Disable ] [ text "Start work" ],
              p [] [text model.text]
            ]
    else
        div []
            [ 
              button [ onClick Expand, disabled model.isButtonDisabled ] [ text "Working..." ],
              p [] [text ("Time left to work: " 
                ++ (toString (model.timeToWork - model.timerCount)) ++ " --- "
                ++ (toString (model.countOfPomodoro)) ++ " --- "
                ++ (toString (model.timerStarted)))
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
            
            
              let countOfPomodoroNew = if model.timeToWork - model.timerCount == 0 
              then
              model.countOfPomodoro + 1 else model.countOfPomodoro
            in
            
           
        
            
            let isRestingNow = if (countOfPomodoroNew % 4 == 0) 
                    then
                      True 
                    else False
            in
        
            let restingTimerCount = if (model.isRestingNow == True) then model.timeToRest - 1 else 10
            in
            
             let shouldStopTimer = if (model.timeToRest - restingTimerCount == 0 && isRestingNow == True) then False else True
            in

            
            let isStopWorking = if (model.timeToWork - model.timerCount == 0 ) then False else True
            in
            
            let newTimerCount = if isRestingNow == True then 0 else model.timerCount + 1 
            
            in
            
         
            let willButtonBeDisabled = if isStopWorking == True then
                  True else False
            in
            
            ({
              model
                | timerCount = newTimerCount ,
                  countOfPomodoro = countOfPomodoroNew,
                  isButtonDisabled = willButtonBeDisabled,
                  text = 
                  if isRestingNow == True
                  then 
                  "Rest now for " ++ toString(model.timeToRest) ++ " seconds"
                  else "Please press Start Work when you ready",
                  isRestingNow = isRestingNow,
                  timerStarted = shouldStopTimer,
                  isWorking = isStopWorking,
                  restingTimerCount = restingTimerCount
                  
                  
        
                  
            }, Cmd.none )
         
                    
           

subscriptions : Model -> Sub Msg
subscriptions model = 
    if model.isWorking == True || model.isRestingNow == True
    then Time.every second Tick else Sub.none
  
    

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
