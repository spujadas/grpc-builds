#!/bin/bash

# Install gRPC for the host architecture (need protoc and grpc_cpp_plugin to cross-compile)

set -ex

pushd "build/linux-x64"
make install
popd
