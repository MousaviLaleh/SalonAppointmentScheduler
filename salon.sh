
#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n" 

MAIN_MENU() {
    if [[ $1 ]]
    then
        echo -e "\n$1"
    fi
    # show services
    SERVICE_LIST=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id") 
    echo "$SERVICE_LIST" | while read SERVICE_ID BAR SERVICE_NAME
    do
        echo -e "$SERVICE_ID) $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g')"
    done
    read SERVICE_ID_SELECTED
    # get customer input
    SERVICE=$(echo $($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'") | sed -r 's/^ *| *$//g')
    # if not a valid service
    if [[ -z $SERVICE ]]
    then
        MAIN_MENU "\nI could not find that service. What would you like today?"
    else
        # get customer phone number
        echo -e "\nWhat's your phone number?"
        read CUSTOMER_PHONE
        # chech if it's new or not
        CUSTOMER_NAME=$(echo $($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'") | sed -r 's/^ *| *$//g')
        # if is a new customer
        if [[ -z $CUSTOMER_NAME ]]
        then
            #get customer info
            echo -e "\nI don't have a record for that phone number, what's your name?"
            read CUSTOMER_NAME
            CUSTOMER_INFO_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
            echo -e "\nWhat time would you like your $(echo $SERVICE)?"
            read SERVICE_TIME
            CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
            #update appointments
            APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
            echo -e "\nI have put you down for a $(echo $SERVICE | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $CUSTOMER_NAME.\n"

        # if not a new customer
        else
            # get the time
            echo -e "\nWhat time would you like your $(echo $SERVICE), $CUSTOMER_NAME?"
            read SERVICE_TIME            
            # update appointment
            CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
            APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
            echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME.\n"
        fi

    fi
}

MAIN_MENU
