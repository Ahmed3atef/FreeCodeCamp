#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo "$($PSQL "TRUNCATE TABLE teams, games")"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS 
do
  if [[ $YEAR != "year" ]]
  then
    # get winner_id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    # search if it exists
    if [[ -z $WINNER_ID ]]
    then 
      # insert into teams table
      INSERT_WINNER_TEAM=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")
      # if it inserted correctly 
      if [[ $INSERT_WINNER_TEAM == "INSERT 0 1" ]]
      then
        # indecate it that inserted
        echo "One new Team inserted, $WINNER"
      fi
      # get the id of team from the table
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi

    # check if opponent arredy in my table
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # if is not there
    if [[ -z $OPPONENT_ID ]]
    then
      # add opponent to teams table
      INSERT_OPPONENT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT') ")
      # if it inserted correctly 
      if [[ $INSERT_OPPONENT_TEAM == "INSERT 0 1" ]]
      then
        # indecate it that inserted
        echo "One new Team inserted, $OPPONENT"
      fi

      # get the id of team from the table
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi

    INSERT_GAMES_RECORD=$($PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ('$YEAR', '$ROUND', '$WINNER_ID', '$OPPONENT_ID', $WINNER_GOALS, $OPPONENT_GOALS) ")
    if [[ $INSERT_GAMES_RECORD == "INSERT 0 1" ]]
    then
      echo "New Row added ( $YEAR, $ROUND, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)"
    fi
  fi
done
