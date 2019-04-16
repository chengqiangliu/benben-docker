#!/bin/bash

DIR="$( cd "$(dirname "$0")" && pwd )"
cd $DIR/../

export COMPOSE_PROJECT_NAME=:local

# stop MySQL container if it's already running
echo "Stop MySQL container..."
docker-compose stop mysql

# remove MySQL container if exist
echo "Remove MySQL container..."
docker-compose rm -f mysql

# create and start mysql container(means install mysql and start mysql service)
echo "Setup MySQL..."
docker-compose up --no-recreate -d mysql

echo "Waiting for MySQL service ready..."

waitTime=0
until docker-compose exec mysql mysql -e "exit" &> /dev/null; do
  echo "Waiting anther 5 seconds..."
  sleep 5
  waitTime=$(($waitTime + 5))
  if [ "$waitTime" -gt "120" ]; then
    echo "Due to some unknown reason, MySQL starts failed."
    docker-compose stop ${SERVICE_NAME}
    exit 1;
  fi
done
echo "MySQL is ready"