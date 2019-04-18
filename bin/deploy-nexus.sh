#!/bin/bash

DIR="$( cd "$(dirname "$0")" && pwd )"
cd $DIR/../

export COMPOSE_PROJECT_NAME=:local

# stop nexus3 container
echo "Stop nexus3 container..."
docker-compose stop nexus3

echo "Remove nexus3 container..."
docker-compose rm -f nexus3

# start nexus3 container
echo "Deploy nexus3..."
docker-compose up --no-recreate -d nexus3
if [ $? -eq 0 ]; then
   echo "Deploy nexus3 is done"
else
   echo "error happened when deploying nexus3"
fi