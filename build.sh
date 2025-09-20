#!/usr/bin/env bash

if [ $# -eq 1 ]; then
  QUASAR_CLI_VERSION=$1
else
  QUASAR_CLI_VERSION=$(npm view @quasar/cli version)
  echo "quasar cli version: $QUASAR_CLI_VERSION"
fi
IMAGE_NAME="stove/quasar-cli"

docker build -t ${IMAGE_NAME}:${QUASAR_CLI_VERSION} .
docker tag ${IMAGE_NAME}:${QUASAR_CLI_VERSION} ${IMAGE_NAME}:latest

echo "build image:"
echo "- ${IMAGE_NAME}:${QUASAR_CLI_VERSION}"
echo "- ${IMAGE_NAME}:latest"

# 이미지 push
echo "push image"
docker push ${IMAGE_NAME}:${QUASAR_CLI_VERSION}
docker push ${IMAGE_NAME}:latest
