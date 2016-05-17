import Html exposing (Html, div, p, text)
import Html.App as App
import Html.Attributes exposing (..)
import Time exposing (Time, second)

origTime = 1463324400

fmtTime time =
  let days = time // (60 * 60 * 24)
      hours = (time // (60 * 60)) - days * 24
      minutes = (time // 60) - (hours * 60) - (days * 60 * 24)
      seconds = time `rem` 60
    in (toString days) ++ " days, " ++ (toString hours) ++ " hours, " 
    ++ (toString minutes) ++ " minutes, and " ++ (toString seconds) ++ " seconds"

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model = Int


init : (Model, Cmd Msg)
init =
  (origTime, Cmd.none)


-- UPDATE

type Msg
  = Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Tick newTime ->
      let inttime = round <| Time.inSeconds newTime in
        (inttime - origTime, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick


-- VIEW

view : Model -> Html Msg
view model =
  div [class "container"] 
    [ p [] [ text "it has been"]
    , p [class "the-time"] [ text <| fmtTime model ]
    , p [] [ text "of joyless grey misery since James last tasted a cigarette" ]
    ]
