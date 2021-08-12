#!/bin/bash
set -eu 
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}

DOCKERFILE_DIR=./docker
DOCKER_IMAGE_NAME=packer-raspberrypi-imager
OUTPUT_IMAGE_DIR=raspberry-pi-image

docker build -t ${DOCKER_IMAGE_NAME} ${DOCKERFILE_DIR}

sudo rm -fR ./${OUTPUT_IMAGE_DIR}
docker run \
  --rm \
  --privileged \
  -v ${PWD}:/build:ro \
  -v ${PWD}/packer_cache:/build/packer_cache \
  -v ${PWD}/${OUTPUT_IMAGE_DIR}:/build/output-arm-image \
  ${DOCKER_IMAGE_NAME} build /build/packer_raspberrypi.json