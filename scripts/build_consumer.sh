#!/bin/bash
### build kafka consumer ###
pushd ../kafkacat_consumer
docker build -t kafkacat_consumer:latest . 
popd