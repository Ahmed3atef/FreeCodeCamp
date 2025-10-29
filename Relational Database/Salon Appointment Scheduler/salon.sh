#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services")
  echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME 
  do
    echo "$SERVICE_ID) $NAME"
  done

  read SERVICE_ID_SELECTED
  SERVICE_ID_TO_USE=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  SERVICE_NAME_TO_USE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_ID_TO_USE ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER_ID ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
      BOOKING $CUSTOMER_ID $SERVICE_ID_TO_USE $CUSTOMER_NAME $SERVICE_NAME_TO_USE
    else
      BOOKING $CUSTOMER_ID $SERVICE_ID_TO_USE $CUSTOMER_NAME $SERVICE_NAME_TO_USE
    fi
  fi
    
}

BOOKING(){
  echo -e "\nWhat time would you like your $4, $3?"
  read SERVICE_TIME
  INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($1, $2, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $4 at $SERVICE_TIME, $3."
}



echo -e "Welcome to My Salon, how can I help you? \n"
MAIN_MENU 
