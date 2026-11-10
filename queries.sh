#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals) + SUM(opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),16) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals) + AVG(opponent_goals),16) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(1) FROM games WHERE WINNER_GOALS>2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT NAME FROM TEAMS RIGHT JOIN GAMES ON TEAM_ID = WINNER_ID WHERE YEAR=2018 AND ROUND='Final' ORDER BY NAME")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT NAME FROM TEAMS LEFT JOIN GAMES ON (TEAM_ID = WINNER_ID OR TEAM_ID = OPPONENT_ID) WHERE YEAR=2014 AND ROUND='Eighth-Final' ORDER BY NAME")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT NAME FROM TEAMS RIGHT JOIN GAMES ON TEAM_ID = WINNER_ID ORDER BY NAME")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT YEAR, NAME FROM TEAMS RIGHT JOIN GAMES ON TEAM_ID = WINNER_ID WHERE ROUND='Final' ORDER BY year ASC")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT NAME FROM TEAMS WHERE NAME LIKE 'Co%'")"
