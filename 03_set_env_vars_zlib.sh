#!/bin/bash

# directories and files
export ZLIB_CPACK_CONFIG_FILE=${BASE_DIR}/CPackConfig-zlib.cmake
export ZLIB_SOURCE_DIR=${BASE_DIR}/grpc/third_party/zlib
export ZLIB_GUEST_BUILD_DIR=${BASE_DIR}/build/rpi-arm32v6/zlib-guest
export ZLIB_SYSROOT_BUILD_DIR=${BASE_DIR}/build/rpi-arm32v6/zlib-sysroot

# zlib package version and names
export ZLIB_PACKAGE_VERSION=$(perl -n -e'/set\(VERSION\s+"(.*?)"\)/ && print $1' < grpc/third_party/zlib/CMakeLists.txt)
export ZLIB_SYSROOT_PACKAGE_NAME=zlib_sysroot-${ZLIB_PACKAGE_VERSION}-armhf
export ZLIB_GUEST_PACKAGE_NAME=zlib-${ZLIB_PACKAGE_VERSION}-armhf
export ZLIB_GUEST_DEBIAN_PACKAGE_NAME=zlib_${ZLIB_PACKAGE_VERSION}_armhf.deb
