#!/bin/bash
CYAN='\033[0;36m'
RED='\033[1;31m'
NC='\033[0m'

function usage() {
    echo "ARGUMENTS:"
    echo "-b build docker images"
    echo "-r run the project"
}

function quit(){
    echo ""
    echo -e "${RED}Press 'q' to exit${NC}"
    count=0
    while : ; do
        read -n 1 k <&1
        if [[ $k = q ]] ; then
            break
        else
            ((count=$count+1))
    echo ""
    echo -e "${RED}Press 'q' to exit${NC}"
        fi
    done
    echo ""
}

function build() {
    echo -e "${CYAN}CLONING SOURCE CODE${NC}"
    git submodule init
    git submodule update
    
    pushd scripts

    echo -e "${CYAN}BUILDING SERVER${NC}"
    ./build_server.sh

    echo -e "${CYAN}BUILDING CLIENT${NC}"
    ./build_client.sh

    echo -e "${CYAN}BUILDING CONSUMER${NC}"
    ./build_consumer.sh

    popd

    echo -e "${CYAN} BUILD DONE!${NC}"
}

function run () {

    echo -e "${CYAN}SPINNING BROKER${NC}"
    pushd docker_compose
    docker compose up -d kafka
    popd

    sleep 5

    echo -e "${CYAN}INIT BROKER${NC}"
    pushd scripts
    ./init_broker.sh
    popd

    echo -e "${CYAN}SPINNING SERVER${NC}"
    pushd docker_compose
    docker compose up -d server
    popd

    sleep 2

    echo -e "${CYAN}SPINNING CLIENT AND CONSUMER${NC}"
    pushd docker_compose
    docker compose up -d
    popd

    quit

    echo -e "${CYAN}KILLING MICROSERVICES${NC}"
    pushd docker_compose
    docker compose down -t 2 -v
    popd

    echo -e "${CYAN}RUN TERMINATED!${NC}"
}

should_build=0
should_run=0

if [[ $1 = "--help" ]]; then
    usage
    exit 0
fi

while getopts 'br' OPTION; do
  case "$OPTION" in
    r) 
        should_run=1;;
    b) 
        should_build=1;;
  esac
done

if [ $should_build -eq 1 ]; then
    build
fi

if [ $should_run -eq 1 ]; then
    run
fi

if [[ $should_build -eq 0 && $should_run -eq 0  ]]; then
     echo "Checkout help page: $0 --help"
     exit 1
fi

exit 0