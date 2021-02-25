#!/bin/bash

DIR="$( cd "$(dirname "$0")" && pwd )"
cd $DIR/../

export COMPOSE_PROJECT_NAME=:local

# stop jenkins container
echo "Stop jenkins container..."
docker-compose stop jenkins

echo "Remove jenkins container..."
docker-compose rm -f jenkins

# start jenkins container
echo "Deploy jenkins..."
docker-compose up --no-recreate -d jenkins
if [ $? -eq 0 ]; then
   echo "Deploy jenkins is done"
else
   echo "error happened when deploying jenkins"
fi