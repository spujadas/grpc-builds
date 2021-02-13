#!/bin/bash

# check out specified version of grpc

# check that version of grpc to check out is set in env var
source utils.sh
check_env_var TAG

set -ex

# clone grpc repo
git clone https://github.com/grpc/grpc.git

pushd grpc

# switch to specific tag
git checkout tags/${TAG}

# recursively update grpc's submodules
git submodule update --init --recursive

popd
