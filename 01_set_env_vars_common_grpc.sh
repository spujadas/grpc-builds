#!/bin/bash

# gRPC version
export TAG_FILENAME=grpc-tag.txt
export TAG=$(head -n 1 $TAG_FILENAME)

# directories and files
export BASE_DIR=$(pwd)
export SYSROOT_PREFIX=/tmp/raspberrypi_root
export CROSS_COMPILER_INSTALL_DIR=${BASE_DIR}/raspberry-tools
export CROSS_COMPILER_ROOT=${CROSS_COMPILER_INSTALL_DIR}/arm-bcm2708/arm-linux-gnueabihf
export TOOLCHAIN_FILE=${BASE_DIR}/rpi-toolchain.cmake
export GRPC_CPACK_CONFIG_FILE=${BASE_DIR}/CPackConfig-grpc.cmake

export GUEST_INSTALL_PREFIX=/usr/local
export HOST_INSTALL_PREFIX=/usr/local

export GRPC_SOURCE_DIR=${BASE_DIR}/grpc
export GRPC_HOST_BUILD_DIR=${BASE_DIR}/build/linux-x64
export GRPC_GUEST_BUILD_DIR=${BASE_DIR}/build/rpi-arm32v6/grpc

# URLs
export CROSS_COMPILER_GIT_REPOSITORY=https://github.com/raspberrypi/tools.git

# gRPC package version and names
export GRPC_PACKAGE_VERSION=${TAG#v}
export GRPC_HOST_PACKAGE_NAME=grpc-${GRPC_PACKAGE_VERSION}-amd64
export GRPC_HOST_DEBIAN_PACKAGE_NAME=grpc_${GRPC_PACKAGE_VERSION}_amd64.deb
export GRPC_SYSROOT_PACKAGE_NAME=grpc_sysroot-${GRPC_PACKAGE_VERSION}-armhf
export GRPC_GUEST_PACKAGE_NAME=grpc-${GRPC_PACKAGE_VERSION}-armhf
export GRPC_GUEST_DEBIAN_PACKAGE_NAME=grpc_${GRPC_PACKAGE_VERSION}_armhf.deb
