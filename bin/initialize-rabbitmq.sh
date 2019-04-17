#!/bin/bash

DIR="$( cd "$(dirname "$0")" && pwd )"
cd $DIR/../

export COMPOSE_PROJECT_NAME=:local

# stop rabbitmq container if it's already running
echo "Stop RabbitMQ container..."
docker-compose stop rabbitmq

# remove rabbitmq container if exist
echo "Remove RabbitMQ container..."
docker-compose rm -f rabbitmq

# create and start Rabbitmq container
echo "Setup RabbitMQ..."
docker-compose up --no-recreate -d rabbitmq

echo "Waiting for RabbitMQ service ready..."

# get container name
containerID=$(docker ps --filter "name=rabbitmq" --format "{{.ID}}" --no-trunc)

until docker exec -i $containerID curl http://localhost:15672/#/ &> /dev/null; do
    echo "Waiting anther 5 seconds..."
    sleep 5
done
echo "RabbitMQ service is ready"