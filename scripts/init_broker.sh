#!/bin/bash

docker exec -it kafka rpk topic create test --partitions 20 --brokers=localhost:9092