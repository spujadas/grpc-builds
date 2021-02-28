#!/bin/bash

# build gRPC for Raspberry Pi (armhf)


### initialise

# check if all required environment variables are set
source utils.sh
check_env_var BASE_DIR
check_env_var GUEST_INSTALL_PREFIX
check_env_var SYSROOT_PREFIX
check_env_var TOOLCHAIN_FILE
check_env_var GRPC_CPACK_CONFIG_FILE
check_env_var GRPC_PACKAGE_VERSION
check_env_var GRPC_SOURCE_DIR
check_env_var GRPC_SYSROOT_PACKAGE_NAME
check_env_var GRPC_GUEST_PACKAGE_NAME
check_env_var GRPC_GUEST_DEBIAN_PACKAGE_NAME
check_env_var GRPC_GUEST_BUILD_DIR

set -ex

### build for host

# create build directory
mkdir -p ${GRPC_GUEST_BUILD_DIR}
pushd ${GRPC_GUEST_BUILD_DIR}
rm -Rf *

# set up cross-compilation for host installation

cmake \
  -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_INSTALL_PREFIX=${SYSROOT_PREFIX} \
  -DgRPC_ZLIB_PROVIDER=package \
  -DgRPC_INSTALL=ON \
  ${GRPC_SOURCE_DIR}


# set directories where libraries should be searched for
export LD_LIBRARY_PATH=${CROSS_COMPILER_ROOT}/lib:$LD_LIBRARY_PATH

# compile and preinstall for packaging
make -j8 preinstall

# package to TGZ (for use outside CI)
cpack \
  --config ${GRPC_CPACK_CONFIG_FILE} \
  -D CPACK_GENERATOR="TGZ" \
  -D CPACK_PACKAGE_VERSION=${GRPC_PACKAGE_VERSION} \
  -D CPACK_PACKAGE_FILE_NAME=${GRPC_SYSROOT_PACKAGE_NAME} \
  -D CPACK_INSTALL_CMAKE_PROJECTS="$(pwd);grpc;ALL;/" \
  -D CPACK_PACKAGING_INSTALL_PREFIX=${SYSROOT_PREFIX}

# copy TGZ package to base directory
cp ${GRPC_SYSROOT_PACKAGE_NAME}.tar.gz ${BASE_DIR}

# set up cross-compilation for guest installation
cmake \
  -DCMAKE_TOOLCHAIN_FILE=${BASE_DIR}/rpi-toolchain.cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_INSTALL_PREFIX=${GUEST_INSTALL_PREFIX} \
  -DgRPC_ZLIB_PROVIDER=package \
  -DgRPC_INSTALL=ON \
  ${GRPC_SOURCE_DIR}

# package to TGZ and DEB for guest
cpack \
  --config ${GRPC_CPACK_CONFIG_FILE} \
  -D CPACK_PACKAGE_VERSION=${GRPC_PACKAGE_VERSION} \
  -D CPACK_PACKAGE_FILE_NAME=${GRPC_GUEST_PACKAGE_NAME} \
  -D CPACK_INSTALL_CMAKE_PROJECTS="$(pwd);grpc;ALL;/" \
  -D CPACK_PACKAGING_INSTALL_PREFIX=${GUEST_INSTALL_PREFIX} \
  -D CPACK_DEBIAN_PACKAGE_ARCHITECTURE="armhf" \
  -D CPACK_DEBIAN_FILE_NAME=${GRPC_GUEST_DEBIAN_PACKAGE_NAME}

# copy DEB and TGZ package to base directory
cp ${GRPC_GUEST_PACKAGE_NAME}.tar.gz ${BASE_DIR}
cp ${GRPC_GUEST_DEBIAN_PACKAGE_NAME} ${BASE_DIR}

popd
