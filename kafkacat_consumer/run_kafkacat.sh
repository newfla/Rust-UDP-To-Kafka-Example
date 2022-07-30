#!/bin/bash

kafkacat -b kafka:29092 -C -t $TOPIC -f 'Topic %t[%p], offset: %o, key: %k, payload: %S\n"' 