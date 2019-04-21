#!/bin/bash

DIR="$( cd "$(dirname "$0")" && pwd )"
cd $DIR

SERVICE_NAME="$1"
echo "SERVICE_NAME: $SERVICE_NAME"

case $SERVICE_NAME in
  "filebeat" | "kibana" | "logstash" | "openjdk8" | "nginx" | "nodejs" | "elasticsearch" | "nexus3" | "jenkins" )
    cd ../dockerfiles/$SERVICE_NAME

    image_count=$(docker images --format "{{.Repository}}\t{{.ID}}" --no-trunc | grep "benben/$SERVICE_NAME" | wc -c)
    if [ $image_count -ne 0 ]; then
        echo "remove docker image(benben/$SERVICE_NAME)..."
        docker rmi -f $(docker images --format "{{.Repository}}\t{{.ID}}" --no-trunc | grep "benben/$SERVICE_NAME" | awk '{print $2}')
    fi

    echo -e "\nStarting to build docker image for $SERVICE_NAME...\n"
    docker build -t benben/$SERVICE_NAME .
    echo -e "Build docker image for $SERVICE_NAME successfully\n"

    echo -e "Show all the images of $SERVICE_NAME"
    docker images benben/$SERVICE_NAME
    ;;
  *)
    echo "The $SERVICE_NAME is not found"
    ;;
esac