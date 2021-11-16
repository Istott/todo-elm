module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

main =
    Browser.sandbox { init = todoState, update = update, view = view }

--model (this is where I store state)

type alias Todo = 
    { text : String
    , completed : Bool
    }

type alias Model =
    { todos : List Todo
    , inputText : String
    }

todoState : Model
todoState =
    { todos = []
    , inputText = ""
    }

-- msg (this is my actions or my event triggers)

type Msg
    = AddTodo
    | RemoveTodo Int
    | ToggleTodo Int
    | ChangeInput String

-- update (this is my reducer, this is where I change/update state)

update : Msg -> Model -> Model
update message model
    = case message of
        AddTodo -> 
            { model | todos = addToList model.inputText model.todos
                , inputText = ""
            }
        RemoveTodo index -> 
            { model | todos = removeFromList index model.todos }
        ToggleTodo index ->
            { model | todos = toggleAtIndex index model.todos }
        ChangeInput input ->
            { model | inputText = input }

addToList : String -> List Todo -> List Todo
addToList input todos =
    todos ++ [{ text = input, completed = False }]

removeFromList : Int -> List Todo -> List Todo
removeFromList index list =
    List.take index list ++ List.drop (index + 1) list

toggleAtIndex : Int -> List Todo -> List Todo
toggleAtIndex indexToToggle list =
    List.indexedMap (\currentIndex todo -> 
        if currentIndex == indexToToggle then 
            { todo | completed = not todo.completed } 
        else 
            todo
    ) list


-- view (this is where I render the ui)

viewTodo : Int -> Todo -> Html Msg
viewTodo index todo =
    li
        [ style "text-decoration"
            (if todo.completed then
                "line-through"
             else
                "none"
            )
        ]
        [ text todo.text
        , button [ type_ "button", onClick (ToggleTodo index) ] [ text "Toggle" ]
        , button [ type_ "button", onClick (RemoveTodo index) ] [ text "Delete" ]
        ]


view : Model -> Html Msg
view model =
    Html.form [ onSubmit AddTodo ]
        [ h1 [] [ text "Todos in Elm" ]
        , input [ value model.inputText, onInput ChangeInput, placeholder "What do you want to do?" ] []
        , if List.isEmpty model.todos then
            p [] [ text "The list is clean 🧘‍♀️" ]
          else
            ol [] (List.indexedMap viewTodo model.todos)
        ]