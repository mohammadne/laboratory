#!/bin/bash

if ! command -v docker &> /dev/null
then
    echo "docker could not be found in your system"
    exit
fi

docker images --quiet --filter=dangling=true | xargs --no-run-if-empty docker rmi
