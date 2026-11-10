#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

tail -n +2 games.csv | while IFS=, read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
  WINNER_ID=$($PSQL "SELECT TEAM_ID FROM TEAMS WHERE NAME='$WINNER'")
  if [[ -z $WINNER_ID ]]
  then
    INSERT_WINNER=$($PSQL "INSERT INTO TEAMS(NAME) VALUES('$WINNER')")
    WINNER_ID=$($PSQL "SELECT TEAM_ID FROM TEAMS WHERE NAME='$WINNER'")
  fi
  OPPONENT_ID=$($PSQL "SELECT TEAM_ID FROM TEAMS WHERE NAME='$OPPONENT'")
  if [[ -z $OPPONENT_ID ]]
  then
    INSERT_OPPONENT=$($PSQL "INSERT INTO TEAMS(NAME) VALUES('$OPPONENT')")
    OPPONENT_ID=$($PSQL "SELECT TEAM_ID FROM TEAMS WHERE NAME='$OPPONENT'")
  fi
  INSERT_GAME=$($PSQL "INSERT INTO GAMES(YEAR,ROUND,WINNER_ID,OPPONENT_ID,WINNER_GOALS,OPPONENT_GOALS) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")

done