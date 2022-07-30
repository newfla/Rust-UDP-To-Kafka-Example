#!/bin/bash
### build udp stress client ###
pushd ../udp_client
cp -r ../Rust-UDP-Traffic-Generator client
docker build -t udpclient:latest . 
rm -rf client
popd