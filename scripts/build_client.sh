#!/bin/bash
### build udp stress client ###
pushd ../udp_client
mkdir client
cp -r ../crab-net/src client
cp ../crab-net/Cargo.toml client
docker build -t udpclient:latest . 
rm -rf client
popd