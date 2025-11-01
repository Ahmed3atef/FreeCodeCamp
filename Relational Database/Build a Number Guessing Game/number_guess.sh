#!/bin/bash
# Define PSQL variable
PSQL="psql --username=freecodecamp --dbname=number_guess -X -t --no-align -c"


# Function to generate a random number
GENERATE_RANDOM_NUMBER(){
  RN=$((RANDOM % 1000 + 1))
  echo $RN
}

# Function to register a new user
REGISTER_NEW_USER() {
    INSERT_NEW_USER=$($PSQL "INSERT INTO users(username) VALUES('$1')")
    echo "Welcome, $1! It looks like this is your first time here."
}

# Function to merge the get user status for db
GET_USER_STATS(){
  $PSQL "
  SELECT 
    u.user_id, 
    u.username, 
    COUNT(g.game_id), 
    MIN(g.number_of_gusses) 
  FROM users as u 
  FULL JOIN games as g 
  USING(user_id) 
  WHERE u.username = '$1' 
  GROUP BY u.user_id, u.username
  "
}

START_GAME(){
  # get what returned from the function into var called NUMBER_GENERATED
  SECRET_NUMBER=$(GENERATE_RANDOM_NUMBER)
  local GUESS_COUNT=0

  echo "Guess the secret number between 1 and 1000:"
  
  while read GUESS; do
      if ! [[ $GUESS =~ ^[0-9]+$ ]]; then
          echo "That is not an integer, guess again:"
          continue
      fi
      
      GUESS_COUNT=$((GUESS_COUNT + 1))

      if (( GUESS < SECRET_NUMBER )); then
          echo "It's higher than that, guess again:"
      elif (( GUESS > SECRET_NUMBER )); then
          echo "It's lower than that, guess again:"
      else
        break # Correct Guess!
      fi
  done

  # Save game results using the global USER_ID
  INSERT_GAME=$($PSQL "INSERT INTO games(user_id, number_of_gusses) VALUES($1, $GUESS_COUNT)")
  if [[ $INSERT_GAME = 'INSERT 0 1' ]]
  then
    echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
  else
    exit 1
  fi

}

GET_USER(){
  # Check user existence: Returns ID if found, empty if not.
  local CHECK_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$1'")


  if [[ -z $CHECK_ID ]] # User not found
  then
    REGISTER_NEW_USER "$1"
  fi

  # Get user stats (for existing or newly registered user)
  local USER_INFO=$(GET_USER_STATS "$1")


  
  IFS="|" read USER_ID USER_NAME GAMES_PLAYED MINI_GUSSES <<< "$USER_INFO"
  # Check if the user is returning (GAMES_PLAYED > 0 and a best score exists)
  if [[ $GAMES_PLAYED -gt 0 && -n $MINI_GUSSES ]]; then
    echo "Welcome back, $USER_NAME! You have played ${GAMES_PLAYED:-0} games, and your best game took ${MINI_GUSSES:-0} guesses."
  fi

  START_GAME $USER_ID

}

START(){
  echo -e "Enter your username:"
  read USERNAME
  if [[ -z $USERNAME || ${#USERNAME} -gt 22 ]]; then
      echo "Invalid username. Please try again."
      exit 1
  fi
  # Call GET_USER and pass the username
  GET_USER "$USERNAME"
}

START
