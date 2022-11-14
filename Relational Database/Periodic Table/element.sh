#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# get argument from terminal and check if valid
if [[ $1 ]]
then
  # get the record from database
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENTS=$($PSQL "SELECT atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type, name, symbol FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE elements.atomic_number = $1 ORDER BY atomic_number LIMIT 1")  
  elif [[ $1 =~ ^[a-zA-Z]+$ ]]
  then
    ELEMENTS=$($PSQL "SELECT atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type, name, symbol FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE elements.name = '$1' OR elements.symbol = '$1' ORDER BY atomic_number LIMIT 1")
  fi
  # if not found
  if [[ -z $ELEMENTS ]]
  then
    # print not found message
    echo  "I could not find that element in the database."
  else
    # print record message
    echo $ELEMENTS | while IFS="\| " read ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE NAME SYMBOL
    do
      echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
else
  echo  "Please provide an element as an argument."
fi