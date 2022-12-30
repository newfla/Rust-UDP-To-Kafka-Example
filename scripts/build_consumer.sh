#!/bin/bash
### build kafka consumer ###
pushd ../kafkacat_consumer
cp -r ../Rust-UDP-To-Kafka-Forwarding/tasks/src/proto/message.proto message.proto
docker build -t kafkacat_consumer:latest . 
rm message.proto
popd