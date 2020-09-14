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

    if [ "$LABEL" == "" ]; then
        LABEL="curl-$C"
    fi
    if [ "$SLEEP_TIME" == "" ]; then
        SLEEP_TIME="5"
    fi
    if [ "$PARALLEL" == "" ]; then
        PARALLEL="1"
    fi

    echo $CMD > "/curl-$C.txt"

    for i in {1..$PARALLEL}; do
        echo "Launching $LABEL ($i)"
        /launch.sh $LABEL $SLEEP_TIME "/curl-$C.txt" &
    done

    if [ "$CMD" == "" ]; then
        break
    fi
    C=$((C+1))
done

