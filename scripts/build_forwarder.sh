#!/bin/bash
### build tokio forwarder ###
pushd ../udp_forwarder
mkdir forwarder
cp -R ../crab-kafka/src forwarder
cp -R ../crab-kafka/examples forwarder
cp ../crab-kafka/Cargo.toml forwarder
cp ../crab-kafka/README.md forwarder
docker build -t udpforwarder:latest . 
rm -rf forwarder
popd