#!/bin/bash

if [ "$USE_TLS" = true ] ; then
    ./client --udp --tls -d $DEST_ADDR -c $CONNECTIONS -l $PAYLOAD_SIZE -r $RATE -w $WORKERS -s $SLEEP_TASK_SPAWN --ca $CA_FILE
else
    ./client --udp -d $DEST_ADDR -c $CONNECTIONS -l $PAYLOAD_SIZE -r $RATE -w $WORKERS -s $SLEEP_TASK_SPAWN --ca $CA_FILE
fi
