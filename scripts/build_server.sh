#!/bin/bash
### build tokio server ###
pushd ../udp_server
cp -r ../Rust-UDP-To-Kafka-Forwarding server
docker build -t tokioserver:latest . 
rm -rf server
popd