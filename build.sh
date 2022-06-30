#!/bin/bash
set -eu 
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}

DOCKERFILE_DIR=./docker
DOCKER_IMAGE_NAME=packer-raspberrypi-imager

DOCKER_BUILDKIT=1 docker build -t ${DOCKER_IMAGE_NAME} ${DOCKERFILE_DIR}

docker run \
  --rm \
  --privileged \
  -v ${PWD}:/build:ro \
  -v ${PWD}/packer_cache:/build/packer_cache \
  -v ${PWD}/output-arm-image:/build/output-arm-image \
  ${DOCKER_IMAGE_NAME} build /build/packer_raspberrypi.json
