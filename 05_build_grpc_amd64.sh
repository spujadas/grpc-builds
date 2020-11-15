#!/bin/bash

# Build gRPC for the host architecture


# check if all required environment variables are set
source utils.sh
check_env_var GRPC_HOST_BUILD_DIR
check_env_var GRPC_CPACK_CONFIG_FILE
check_env_var GRPC_PACKAGE_VERSION
check_env_var GRPC_HOST_PACKAGE_NAME
check_env_var GRPC_HOST_DEBIAN_PACKAGE_NAME
check_env_var HOST_INSTALL_PREFIX

set -ex

# create build directory

mkdir -p ${GRPC_HOST_BUILD_DIR}
pushd ${GRPC_HOST_BUILD_DIR}
rm -Rf *

# set up compilation
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=${HOST_INSTALL_PREFIX} \
  -DgRPC_BUILD_TESTS=OFF \
  -DgRPC_SSL_PROVIDER=package \
  -DgRPC_ZLIB_PROVIDER=package \
  ../../grpc

# compile
make -j8 preinstall

# package to TGZ and DEB (for use outside CI)
cpack \
  --config ${GRPC_CPACK_CONFIG_FILE} \
  -D CPACK_PACKAGE_VERSION=${GRPC_PACKAGE_VERSION} \
  -D CPACK_PACKAGE_FILE_NAME=${GRPC_HOST_PACKAGE_NAME} \
  -D CPACK_DEBIAN_FILE_NAME=${GRPC_HOST_DEBIAN_PACKAGE_NAME} \
  -D CPACK_INSTALL_CMAKE_PROJECTS="$(pwd);grpc;ALL;/" \
  -D CPACK_PACKAGING_INSTALL_PREFIX=${HOST_INSTALL_PREFIX} \
  -D CPACK_DEBIAN_PACKAGE_ARCHITECTURE="amd64" \
  -D CPACK_DEBIAN_PACKAGE_DEPENDS="zlib1g openssl"

# copy DEB and TGZ package to base directory
cp ${GRPC_HOST_PACKAGE_NAME}.tar.gz ${BASE_DIR}
cp ${GRPC_HOST_DEBIAN_PACKAGE_NAME} ${BASE_DIR}

popd
