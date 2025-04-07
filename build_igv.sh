#!/bin/bash

REGISTRY=registry.goldenhelix.com/public
TAG=latest
IGV_VERSION=2.16.0

docker build \
  -t ${REGISTRY}/ghdesktop-igv:${IGV_VERSION} \
  --build-arg BASE_IMAGE="${REGISTRY}/ghdesktop-office-web:${TAG}" \
  -f dockerfile-gh-igv .
