module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

main =
    Browser.sandbox { init = countState, update = update, view = view }

--model (this is where I store state)

type alias Model = 
    Int

countState : Model
countState = 
    0

-- msg (this is my actions or my event triggers)

type Msg
    = Increment
    | Decrement
    | Reset

-- update (this is my reducer, this is where I change/update state)

update : Msg -> Model -> Model
update msg modela =
    case msg of
        Increment ->
            modela + 1
        Decrement ->
            modela - 1
        Reset ->
            modela - modela

-- view (this is where I render the ui)

view : Model -> Html Msg
view modelo =
    div []
        [
            button [ onClick Increment ] [ text "add 1" ]
            , p [] [ text (String.fromInt modelo) ]
            , button [ onClick Decrement ] [ text "subtract 2"]
            , button [ onClick Reset ] [ text "reset" ]
        ]