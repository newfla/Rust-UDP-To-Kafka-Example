#!/bin/bash
### build udp stress client ###
pushd ../udp_client
mkdir client
cp -r ../Rust-UDP-Traffic-Generator/src client
cp ../Rust-UDP-Traffic-Generator/Cargo.toml client
docker build -t udpclient:latest . 
rm -rf client
popd