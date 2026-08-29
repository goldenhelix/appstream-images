#!/bin/bash

REGISTRY=registry.goldenhelix.com/public
DAY=$(date +'%y%m%d')
TAG=latest
OO_VERSION=9.0.4

docker build \
  -t ${REGISTRY}/ghdesktop-onlyoffice:${OO_VERSION} \
  --build-arg BASE_IMAGE="${REGISTRY}/ghdesktop-office-web:${TAG}" \
  -f dockerfile-gh-onlyoffice .

# tag as latest
docker tag ${REGISTRY}/ghdesktop-onlyoffice:${OO_VERSION} ${REGISTRY}/ghdesktop-onlyoffice:latest

# push to registry
#docker push ${REGISTRY}/ghdesktop-onlyoffice:${OO_VERSION}
#docker push ${REGISTRY}/ghdesktop-onlyoffice:latest
