#!/bin/bash

# Install gRPC for the host architecture (need protoc and grpc_cpp_plugin to cross-compile)

set -ex

pushd ${GRPC_HOST_BUILD_DIR}
make install
popd
