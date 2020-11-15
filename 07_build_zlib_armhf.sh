#!/bin/bash

# build zlib for Raspberry Pi (armhf)


### initialise

# check if all required environment variables are set
source utils.sh
check_env_var BASE_DIR
check_env_var SYSROOT_PREFIX
check_env_var TOOLCHAIN_FILE
check_env_var ZLIB_CPACK_CONFIG_FILE
check_env_var ZLIB_PACKAGE_VERSION
check_env_var ZLIB_SOURCE_DIR
check_env_var ZLIB_SYSROOT_PACKAGE_NAME
check_env_var ZLIB_GUEST_PACKAGE_NAME
check_env_var ZLIB_GUEST_DEBIAN_PACKAGE_NAME
check_env_var ZLIB_SYSROOT_BUILD_DIR
check_env_var ZLIB_GUEST_BUILD_DIR
check_env_var GUEST_INSTALL_PREFIX

set -ex


### build for guest in host sysroot

# create build directory
mkdir -p ${ZLIB_SYSROOT_BUILD_DIR}
pushd ${ZLIB_SYSROOT_BUILD_DIR}
rm -Rf *

# set up cross-compilation for guest in host sysroot installation
cmake \
  -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=${SYSROOT_PREFIX} \
  ${ZLIB_SOURCE_DIR}

# compile and preinstall for packaging
make -j8 preinstall

# package to TGZ (for use outside CI)
cpack \
  --config ${BASE_DIR}/CPackConfig-zlib.cmake \
  -D CPACK_GENERATOR="TGZ" \
  -D CPACK_PACKAGE_VERSION=${ZLIB_PACKAGE_VERSION} \
  -D CPACK_PACKAGE_FILE_NAME=${ZLIB_SYSROOT_PACKAGE_NAME} \
  -D CPACK_INSTALL_CMAKE_PROJECTS="$(pwd);zlib;ALL;/" \
  -D CPACK_SET_DESTDIR=ON

# copy TGZ package to base directory
cp ${ZLIB_SYSROOT_PACKAGE_NAME}.tar.gz ${BASE_DIR}

popd


### rebuild for guest
# can't reuse previous build because cmake doesn't overwrite pkg-config variables from
# previous run, and can't overwrite them manually with CMake
# (https://stackoverflow.com/q/27375847/2654646)

# create build directory
mkdir -p ${ZLIB_GUEST_BUILD_DIR}
pushd ${ZLIB_GUEST_BUILD_DIR}
rm -Rf *

# set up cross-compilation for guest installation
cmake \
  -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=${GUEST_INSTALL_PREFIX} \
  ${ZLIB_SOURCE_DIR}

# compile and preinstall for packaging
make -j8 preinstall

# package to TGZ and DEB for guest
cpack \
  --config ${ZLIB_CPACK_CONFIG_FILE} \
  -D CPACK_PACKAGE_VERSION=${ZLIB_PACKAGE_VERSION} \
  -D CPACK_PACKAGE_FILE_NAME=${ZLIB_GUEST_PACKAGE_NAME} \
  -D CPACK_INSTALL_CMAKE_PROJECTS="$(pwd);zlib;ALL;/" \
  -D CPACK_SET_DESTDIR=ON \
  -D CPACK_DEBIAN_FILE_NAME=${ZLIB_GUEST_DEBIAN_PACKAGE_NAME} \
  -D CPACK_DEBIAN_PACKAGE_ARCHITECTURE="armhf"

# copy DEB and TGZ package to base directory
cp ${ZLIB_GUEST_PACKAGE_NAME}.tar.gz ${BASE_DIR}
cp ${ZLIB_GUEST_DEBIAN_PACKAGE_NAME} ${BASE_DIR}

popd
