#!/bin/bash
### build tokio forwarder ###
pushd ../udp_forwarder
cp -r ../Rust-UDP-To-Kafka-Forwarding forwarder
docker build -t udpforwarder:latest . 
rm -rf forwarder
popd