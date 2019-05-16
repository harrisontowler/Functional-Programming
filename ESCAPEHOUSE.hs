import Data.List
import Data.Char



game :: IO (String)
game = do
  putStrLn "    !!!!!!!!!!WELCOME TO ESCAPE HOUSE!!!!!!!!!!"
  putStr "Enter your Players name and press Enter: "
  name <- getLine
  putStrLn "Your Characters name is: "
  putStr (name ++ ".")
  putStrLn " "
  putStrLn ("You wake up in a room sitting on a chair, there is a bowl of fruit on a table in front of you... " ++ name ++ ", What do you want to do?")
  putStrLn " "
  putStrLn ("Select a number and press enter.")
  putStrLn "1. Try to get out of the room?"
  putStrLn "2. Inspect the bowl of fruit?"
  putStrLn "3. Eat the fruit?"
  putStrLn "4. Kill yourself."
  command <- getLine
  case command of
    "1" ->
        putStrLn "You try to get out by using the door. The door handle is electrocuting you. You die."
    "2" ->
        putStrLn "CONDRADULATIONS! You found a secret key under the bowl of fruit!..Please press enter to continue.."
    "3" ->
        do
          putStrLn "You pick the fruit up and eat it"
          putStrLn "As you just woke up in confusion you suddenly remembered you're allergic to all fruits!"
          putStrLn "You go into anaphylactic shock and die."
    "4" ->
        putStrLn "You died..."
    _   ->
        putStrLn "re-read options and restart game as you did not understand."
  putStrLn "Restart game session? if yes press: y"
  restart <- getLine
  if restart == "y"
  then game
  else main

type Location = String
type Direction = String
type Thing = String
type Response = String



type PathMap = [((Location, Direction), Location)]
paths :: PathMap
paths = [
    (("room1", "d"), "room2"),
    (("room2", "u"), "room1"),
    (("room2", "w"), "room2 entrance"),
    (("room2 entrance", "e"), "room2"),
    (("room2 entrance", "s"), "room3"),
    (("room3", "s"), "room1"),
    (("room3", "n"), "room2 entrance")
    ]

type LocationMap = [(Thing, Location)]
locations :: LocationMap
locations =  [
    ("ruby", "room1"),
    ("key", "room2 entrance"),
    ("myself", "room3"),
    -- This is a hack, so I don't have to add more lists to the "World" state
    ("room1", "alive")
    ]

type World = (PathMap, LocationMap, Response)
world :: IO (PathMap, LocationMap, Response)
world = return (paths, locations, "")

main :: IO (String)
main = do
    putStrLn "\n6 YOU HEAR A LOUD RUMMBLE AND TUNNELS SUDDENLY APPEAR!...\n"
    putStrLn instructions
    play_game ( return (paths, locations, ""))
    return "GAME OVER!!!!!"
    
instructions =
    "Enter commands using one or two words.\n" ++
    "Available commands are:\n" ++
    "n  s  e  w  u  d   -- to go in that direction.\n" ++
    "quit               -- to end the game and quit."

play_game :: IO (World) -> IO (World)
play_game world = do
    (paths, locations, response) <- world
    putStrLn response
    putStrLn ""
    do
      putStr "command> "
      command <- getLine
      if command == "quit"
         then return (paths, locations, "Quitting.")
         else play_game ( return (do_command command paths locations))
   
move :: Location -> Direction -> PathMap -> Location
move from direction paths = get (from, direction) paths

do_command :: String -> PathMap -> LocationMap -> World
do_command "n" paths locations = go "n" paths locations
do_command "e" paths locations = go "e" paths locations
do_command "s" paths locations = go "s" paths locations
do_command "w" paths locations = go "w" paths locations
do_command "u" paths locations = go "u" paths locations
do_command "d" paths locations = down_from_room1 "d" paths locations

go :: String -> PathMap -> LocationMap -> World
go direction paths locations = do
            let my_location = get "myself" locations
            let new_location = move my_location direction paths
            let new_locations = put "myself" new_location locations
            let response = describe new_location new_locations
            (paths, new_locations, response)

down_from_room1 :: String -> PathMap -> LocationMap -> World
down_from_room1 direction paths locations =
    if get "myself" locations == "room1" &&
       get "room1" locations == "alive" &&
       get "DEVICE" locations == "holding"
           then (paths, put "myself" "dead" locations, description "room23")
           else go direction paths locations 

-- "get" finds the value of a key in a (key, value) list
get :: Eq a => a -> [(a, String)] -> String
get value list = case lookup value list of
                     Just result -> result
                     Nothing -> "Not found."

put :: Eq t => t -> t1 -> [(t, t1)] -> [(t, t1)]
put key value list =
    let without = filter (\(x, y) -> x /= key) list
    in (key, value) : without

describe :: Location -> LocationMap -> String
describe new_location locations =
    let here = get "myself" locations
        room1_status = get "room1" locations
        ruby_location = get "DEVICE" locations
    in describe_helper here room1_status ruby_location  locations 

describe_helper :: Location -> String -> String -> LocationMap -> String
describe_helper "room3" "dead" "holding" locations = description "room32"
describe_helper "room2" "alive" "holding" locations = description "room23"
describe_helper "room2" "dead" _ locations = description "room22"
describe_helper "room1" "dead" _ locations = description "room12"
describe_helper here _ _ locations = description here

description :: Location -> String
description "room3" =
    "You are in a room3.  To the north is the dark mouth\n" ++
    "of a room2; to the south is a small room5.  Your\n" ++
    "The only way out alive, should you decide to accept it, is to\n" ++
    "recover the Teleportation device and return it to the power station\n" ++
    "this room3."

description "room32" = "Congratulations!!  You have recovered the teleportation device, vanished and ended up back home! and won the game!!!"

description "room2 entrance" =
    "You are in a dark unknown room2.  The exit is to\n" ++
    "the south; there is a large, dark, tunnel to\n" ++
    "the east."

description "room2" =
    "There is a decapitated body room1 here!  both arms torn off, blood\n" ++
    "EVERYWHERE, and is laying directly in front of you!\n" ++
    "I would advise you to leave promptly and quietly...."
    
description "room22" =
    "AAAH!  There is a giant room1 here, Running."

description "room23" =
     "The room1 sees you with the ruby and attacks!!!\n" ++
     "    ...it is over in seconds...."

description "room1" =
    "You walk down Tunnel 1 and reach another room...\n" ++
    "There are dead corpses everywhere, wreaking of rotten flesh...the smell is awful."

description "room12" =
    "Oh, gross!  You're on top of a dead Cow in room1!"

description someplace = someplace ++ ",It is to dark in here to see, choose another direction or proceed forward"



  