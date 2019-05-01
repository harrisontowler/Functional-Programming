game :: IO ()
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
  else game'
 
  
    
game' :: IO ()
game' = do
  putStrLn "4 doors now suddenly appear out of nowhere! which will you try to take???"
  putStrLn "Door 1?"
  putStrLn "Door 2?"
  putStrLn "Door 3?"
  putStrLn "Door 4?"
  command <- getLine
  case command of
    "1" ->
        putStrLn "You try to get out by using the door. The door handle is electrocuting you. You die."
    "2" ->
        putStrLn "This door will not open."
    "3" ->
        do
          putStrLn "Try another door"
          
    "4" ->
        putStrLn "You died."
    _   ->
        putStrLn "re-read options and restart game as you did not understand."
  putStrLn "Restart game session? if yes press: y"
  restart <- getLine
  if restart == "y"
  then game
  else putStrLn "you quit! Thanks for playing!"



  