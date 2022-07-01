#!/bin/bash

RANDOM=$$
RANGE=50

mkdir -p ./logs

while :
do
	VALUE=$((RANDOM % RANGE))
    DATE=$(date '+%d/%m/%Y %H:%M:%S')
    TEXT="value: $VALUE, date: $DATE"

    if (( $VALUE > 40 )); then
        echo "error, $TEXT" >> ./logs/error.logs
    else
        echo "success, $TEXT" >> ./logs/successe.logs
    fi

	sleep 1
done
