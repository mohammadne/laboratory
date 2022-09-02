#!/bin/bash

LOG_DIRECTORY="/var/log/logger"
RANDOM=$$
RANGE=50

# create directory for the logs to be stored in 
mkdir -p $LOG_DIRECTORY

while :
do
	VALUE=$((RANDOM % RANGE))
    DATE=$(date '+%d/%m/%Y %H:%M:%S')
    TEXT="value: $VALUE, date: $DATE"

    if (( $VALUE > 40 )); then
        echo "error, $TEXT" >> "$LOG_DIRECTORY/error.log"
    else
        echo "success, $TEXT" >> "$LOG_DIRECTORY/successe.log"
    fi

	sleep 1
done
