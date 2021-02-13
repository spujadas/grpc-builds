#!/bin/bash

# Install gRPC for the host architecture (need protoc and grpc_cpp_plugin to cross-compile)

set -ex

pushd ${GRPC_HOST_BUILD_DIR}
sudo make install

# update path to libs and refresh
sudo ldconfig -n ${HOST_INSTALL_PREFIX}/lib
sudo ldconfig
popd
