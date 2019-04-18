#!/bin/bash

DIR="$( cd "$(dirname "$0")" && pwd )"
cd $DIR/

NEXUS_DOWNLOAD_URL="http://localhost:8081/service/rest/v1/search/assets?"
NEXUS_REPO="benben-maven-repository"
GROUP="com.benben.ffms"

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

HELP_MSG=' is required.\nThe command should be like: ./build_docker_image.sh -c|--component={component name} -v|--version={version}'
if [ -z $COMPONENT ]; then
    echo -e "COMPONENT $HELP_MSG"
    exit 0
fi

case $COMPONENT in
  "ffms" | "benben-nodejs" )
    ;;
  * )
    echo -e "The component name must be one of (ffms, benben-nodejs)"
    exit 1
    ;;
esac

if [ -z $VERSION ]; then
  echo -e "VERSION  $HELP_MSG"
  exit 0
fi

VERSION_IMAGE_NAME="benben/${COMPONENT}:${VERSION}"
echo "Building gpp-app docker image for $COMPONENT, version: $VERSION ..."
docker rmi ${VERSION_IMAGE_NAME} &> /dev/null

cd benben-app

mkdir -p .tmp
JAR_FILE=.tmp/${COMPONENT}-${VERSION}.jar
JAR_URL=$(curl -sX GET "http://localhost:8081/service/rest/v1/search/assets?repository=benben-maven-repository&group=${GROUP}&name=${COMPONENT}&maven.extension=jar&maven.baseVersion=${VERSION}" | grep "downloadUrl" | awk -F '"' '{print $4}' | sort -r | head -1)
if [ -z "$JAR_URL" ] ; then
  echo "ERROR: The artifact has not been found in the repository - ${NEXUS_REPO}!"
  exit 1
fi

echo Downloading $JAR_URL
wget $JAR_URL -O $JAR_FILE -nv || exit 1

if [[ ! -f $JAR_FILE ]]; then
    echo "$JAR_FILE is not found, please check the version is correct and have you published it to Nexus"
    exit 1
fi
echo JAR_FILE = $JAR_FILE

docker build -t $VERSION_IMAGE_NAME \
       --build-arg COMPONENT=$COMPONENT \
       --build-arg COMPONENT_VERSION=$VERSION \
       .

rm -rf .tmp

docker images $VERSION_IMAGE_NAME