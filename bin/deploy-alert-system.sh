#!/bin/bash

DIR="$( cd "$(dirname "$0")" && pwd )"
cd $DIR/../

export COMPOSE_PROJECT_NAME=:local

# stop kibana container
echo "Stop kibana container..."
docker-compose stop kibana

echo "Remove kibana container..."
docker-compose rm -f kibana

echo "Stop logstash container..."
docker-compose stop logstash

echo "Remove logstash container..."
docker-compose rm -f logstash

echo "Stop elasticsearch container..."
docker-compose stop elasticsearch

echo "Remove elasticsearch container..."
docker-compose rm -f elasticsearch

# start elasticsearch container
echo "Deploy elasticsearch..."
docker-compose up --no-recreate -d elasticsearch
if [ $? -eq 0 ]; then
   echo "Deploy elasticsearch is done"
else
   echo "error happened when deploying elasticsearch"
fi

# start logstash container
echo "Deploy logstash..."
docker-compose up --no-recreate -d logstash
if [ $? -eq 0 ]; then
   echo "Deploy logstash is done"
else
   echo "error happened when deploying logstash"
fi

# start kibana container
echo "Deploy kibana..."
docker-compose up --no-recreate -d kibana
if [ $? -eq 0 ]; then
   echo "Deploy kibana is done"
else
   echo "error happened when deploying kibana"
fi