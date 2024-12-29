#!/bin/bash

REGISTRY=registry.goldenhelix.com/public
DAY=$(date +'%y%m%d')
TAG=latest
OO_VERSION=8.2.2

docker build \
  -t ${REGISTRY}/ghdesktop-onlyoffice:${OO_VERSION} \
  --build-arg BASE_IMAGE="${REGISTRY}/ghdesktop-office-web:${TAG}" \
  -f dockerfile-gh-onlyoffice .
