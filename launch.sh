#!/bin/bash

LABEL=$1
SLEEP_TIME=$2
CMD_FILE=$3

CMD=$(cat $CMD_FILE)
echo "========="
echo "$CMD"
echo "========="

while true; do
    start=`date +%s`
    eval $CMD
    STATUS=$?

    S="failure"
    if [ "$STATUS" = "0" ]; then
      S="success"
    fi

    end=`date +%s`
    echo "CURL=$LABEL:$S-REQUEST_TIME=`expr $end - $start`s-STATUS=$STATUS"

    sleep $SLEEP_TIME
done

