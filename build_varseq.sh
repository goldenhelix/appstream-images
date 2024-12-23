#!/bin/bash

## Parse input ##
REGISTRY=registry.goldenhelix.com/public
DAY=$(date +'%y%m%d')
TAG=$(arch)-${DAY}
VS_VERSION=2.6.2
DOWNLOAD_FILE_SUFFIX="--SP1"
# Set this to true for VarSeq 2, false for VarSeq 3
INSTALL_XDG_OPEN=true

docker build \
  -t ${REGISTRY}/ghdesktop-varseq:${VS_VERSION} \
  --build-arg BASE_IMAGE="${REGISTRY}/ghdesktop-office-web:${TAG}" \
  --build-arg VS_VERSION=${VS_VERSION} \
  --build-arg DOWNLOAD_FILE_SUFFIX=${DOWNLOAD_FILE_SUFFIX} \
  --build-arg INSTALL_XDG_OPEN=${INSTALL_XDG_OPEN} \
  -f dockerfile-gh-varseq .
