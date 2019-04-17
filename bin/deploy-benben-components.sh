#!/bin/bash

DIR="$( cd "$(dirname "$0")" && pwd )"
cd $DIR/../

for i in "$@"; do
case $i in
    -c=*|--component=*)
    COMPONENT="${i#*=}"
    shift
    ;;
    -v=*|--version=*)
    VERSION="${i#*=}"
    shift
    ;;
esac
done

HELP_MSG=' is required.\nThe command should be like: ./deploy_benben_component.sh -c|--component={component name} -v|--version={version}'
if [ -z $COMPONENT ]; then
    echo -e "COMPONENT $HELP_MSG"
    exit 0
fi

export COMPOSE_PROJECT_NAME=:local

case $COMPONENT in
  "benben-ffms" | "benben-nodejs" )
    ;;
  * )
    echo -e "The component name must be one of (benben-ffms, benben-nodejs)"
    exit 1
    ;;
esac

if [ -z $VERSION ]; then
  echo -e "VERSION  $HELP_MSG"
  exit 0
fi

echo "Building docker image for $COMPONENT ..."

# stop component container
echo "Stop $COMPONENT container ..."
docker-compose stop $COMPONENT

# remove component container
echo "Remove $COMPONENT container ..."
docker-compose rm -f $COMPONENT

image_name="benben/${COMPONENT}:${VERSION}"
image_count=$(docker images -q "${image_name}" | wc -l)
if [ $image_count -eq 0 ]; then
    echo " ---------------------------------ERROR----------------------------------------"
    echo "|The version you specified image is not found, please build the image first. |"
    echo " ------------------------------------------------------------------------------"

    exit 1
fi

# start component container
echo "Start to deploy ${image_name}..."
docker-compose up --no-recreate -d ${COMPONENT}

exit 0