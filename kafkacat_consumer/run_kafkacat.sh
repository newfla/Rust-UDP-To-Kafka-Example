#!/bin/bash

if [ "$PROTO" = true ] ; then
    while :
    do
        kafkacat  -b kafka:29092 -C -t $TOPIC  -o -1 -e -q -D "" | protoc --decode=sender.proto.KafkaMessage --proto_path=./ ./message.proto
    done
else
    kafkacat -b kafka:29092 -C -t $TOPIC -f 'Topic %t[%p], offset: %o, key: %k, payload: %S\n"' 
fi
