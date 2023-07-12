#! /bin/bash

### Author F.Bruno ###

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    # getting team_id
    WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'")
    OPPONENT_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")

    # if the values are not found
    if [[ -z $WINNER_ID ]]
    then 
      echo $($PSQL "insert into teams(name) values ('$WINNER')")
     # WINNER_ID = $($PSQL "select team_id from teams where team=$WINNER")
    fi
    if [[ -z $OPPONENT_ID ]]
    then 
      echo $($PSQL "insert into teams(name) values ('$OPPONENT')")
     # OPPONENT_ID = $($PSQL "select team_id from teams where team=$OPPONENT")

    fi
    WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'");
    OPPONENT_ID=$($PSQL "select team_id from teams where name='$OPPONENT'");
    echo $($PSQL "insert into games(year , round , winner_id , opponent_id , winner_goals , opponent_goals)  values ($YEAR , '$ROUND' , $WINNER_ID , $OPPONENT_ID , $WINNER_GOALS , $OPPONENT_GOALS)")
  fi

done
