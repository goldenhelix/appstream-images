#!/bin/bash

## Parse input ##
REGISTRY=registry.goldenhelix.com/public
DAY=$(date +'%y%m%d')
VS_VERSION=3.0.0
DOWNLOAD_FILE_PREFIX="Dev_"
DOWNLOAD_FILE_SUFFIX="-dev-$(date +'%Y-%m-%d')-Nightly-internal-lin64"
DOWNLOAD_BASE_URL="http://proxy.goldenhelix.com:8080/Nightly"
DESKTOP_DAY="241107"

docker build \
  -t ${REGISTRY}/ghdesktop-varseq:${VS_VERSION} \
  --build-arg BASE_IMAGE="${REGISTRY}/ghdesktop-office-web:$(arch)-${DESKTOP_DAY}" \
  --build-arg VS_VERSION=${VS_VERSION} \
  --build-arg DOWNLOAD_BASE_URL=${DOWNLOAD_BASE_URL} \
  --build-arg DOWNLOAD_FILE_PREFIX=${DOWNLOAD_FILE_PREFIX} \
  --build-arg DOWNLOAD_FILE_SUFFIX=${DOWNLOAD_FILE_SUFFIX} \
  -f dockerfile-gh-varseq .