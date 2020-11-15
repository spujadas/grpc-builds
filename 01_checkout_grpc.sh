#!/bin/bash

# check out specified version of grpc

set -ex

TAG_FILENAME=grpc-tag.txt
TAG=$(head -n 1 $TAG_FILENAME)

# update grpc submodule
git submodule update --init

pushd grpc

# switch to specific tag
git checkout tags/${TAG}

# recursively update grpc's submodules
git submodule update --init --recursive

popd
