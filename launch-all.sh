#!/bin/bash

C=1
while true; do
    CMDN="CURL${C}_CMD"
    CMDL="CURL${C}_NAME"
    CMDS="CURL${C}_SLEEP"
    CMDP="CURL${C}_PARALLEL"

    CMD=${!CMDN}
    LABEL=${!CMDL}
    SLEEP_TIME=${!CMDS}
    PARALLEL=${!CMDP}

    if [ "$CMD" == "" ]; then
        break
    fi

    if [ "$LABEL" == "" ]; then
        LABEL="curl-$C"
    fi
    if [ "$SLEEP_TIME" == "" ]; then
        SLEEP_TIME="5"
    fi
    if [ "$PARALLEL" == "" ]; then
        PARALLEL=1
    fi

    echo $CMD > "/curl-$C.txt"

    P=1
    while true; do
        echo "Launching $LABEL ($i)"
        /launch.sh $LABEL $SLEEP_TIME "/curl-$C.txt" &
        P=$((P+1))
        if [ "$P" -gt "$PARALLEL" ]; then
            break
        fi
    done

    C=$((C+1))
done

while true; do
    sleep 1
done

