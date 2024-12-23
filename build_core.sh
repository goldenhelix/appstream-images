#!/bin/bash

## Parse input ##
REGISTRY=registry.goldenhelix.com/public
DAY=$(date +'%y%m%d')

## Build/Push image to cache endpoint by pipeline ID ##
docker build \
  -t ${REGISTRY}/ghdesktop-office-web:$(arch)-${DAY} \
  --build-arg BASE_TAG="$(arch)-debian-bookworm-${DAY}" \
  -f dockerfile-gh-office-web .
