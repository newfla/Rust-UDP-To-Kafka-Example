#!/bin/bash
### build tokio forwarder ###
pushd ../udp_forwarder
mkdir forwarder
cp -r ../Rust-UDP-To-Kafka-Forwarding/src forwarder
cp -r ../Rust-UDP-To-Kafka-Forwarding/tasks forwarder
cp -r ../Rust-UDP-To-Kafka-Forwarding/utilities forwarder
cp ../Rust-UDP-To-Kafka-Forwarding/Cargo.toml forwarder
docker build -t udpforwarder:latest . 
rm -rf forwarder
popd