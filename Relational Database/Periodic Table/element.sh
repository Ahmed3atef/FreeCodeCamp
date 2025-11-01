#! /bin/bash

# Initialize PSQL command with desired flags
PSQL="psql --username=freecodecamp --dbname=periodic_table -X -t --no-align -c"

# Check if an element argument was provided
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  # Exit the script after printing the message
  exit 0
fi

GET_ELEMENT(){
  local INPUT=$1
  local QUERY=""
  local ELEMENTS=""

  # to correctly distinguish between atomic number (digits) and name/symbol (letters).
  if [[ $INPUT =~ ^[0-9]+$ ]]
  then
    # Input is a number (Atomic Number)
    QUERY="elements.atomic_number = $INPUT"
  elif [[ $INPUT =~ ^[a-zA-Z]+$ ]]
  then
    # Input is a string (Name or Symbol)
    QUERY="elements.name = '$INPUT' OR elements.symbol = '$INPUT'"
  fi

  # If a valid query was built, execute the PSQL command
  if [[ ! -z $QUERY ]]
  then
    ELEMENTS=$($PSQL "
      SELECT 
        atomic_number, 
        atomic_mass, 
        melting_point_celsius, 
        boiling_point_celsius, 
        types.type, 
        name, 
        symbol 
      FROM properties 
      JOIN elements USING(atomic_number) 
      JOIN types USING(type_id) 
      WHERE $QUERY 
      ORDER BY atomic_number 
      LIMIT 1"
    )
  fi

  # Check if a result was found
  if [[ -z $ELEMENTS ]]
  then
    echo "I could not find that element in the database."
    return
  fi

  # Output the required format
  echo "$ELEMENTS" | while IFS="\| " read ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE NAME SYMBOL
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
}

GET_ELEMENT $1
