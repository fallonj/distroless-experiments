#!/bin/sh

DOCKER_REGISTRY_AND_IMAGE='registry.digitalocean.com/release/img-distroless-experiment'
DO_API_KEY=$1

#bash colours
NOCOLOR='\033[0m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

SCRIPT_NAME=`basename "$0"`
SCRIPT_DIR=$( cd ${0%/*} && pwd -P )
echo "${GREEN}The script you are running is ${SCRIPT_DIR}/${SCRIPT_NAME}${NOCOLOR}"
echo "${GREEN}Deploying to Digtal Ocean${NOCOLOR}"

#build docker image and push to local docker registry
docker build -t ${DOCKER_REGISTRY_AND_IMAGE} ${SCRIPT_DIR}/..
docker push ${DOCKER_REGISTRY_AND_IMAGE}

#install on the kubernetes cluster - find a way to exclude this api key from this git repo
helm upgrade --install distroless-experiments --set image.repository="${DOCKER_REGISTRY_AND_IMAGE}" --set apiKey="${DO_API_KEY}" ${SCRIPT_DIR}/../helm-charts/distroless-experiments