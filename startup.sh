#!/bin/sh

if [ "$CURL1_CMD" = "" ]; then
    echo "CURL1_CMD is required"
    exit 1
fi

echo "Starting curl loop with promgrep activated. Check http://0.0.0.0:8880/metrics"

/launch-all.sh | promgrep \
                    --summary "request@CURL=(.*)-REQUEST_TIME=([0-9]+)s-STATUS=(.*)"
