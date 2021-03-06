#!/bin/bash

DOCKER_IMAGE='quay.io/pypa/manylinux2010_x86_64'
PLAT='manylinux2010_x86_64'

rm -rf build/*

docker pull "$DOCKER_IMAGE"

docker container run -t --rm \
      -e PLAT=$PLAT \
      -v "$(pwd)":/io \
      "$DOCKER_IMAGE" /io/build_wheels.sh