#!/bin/bash

# install prerequisites

# check required environment variables
source utils.sh
check_env_var CROSS_COMPILER_ROOT
check_env_var CROSS_COMPILER_RELATIVE_URL

set -ex

# install libssl-dev and libz-dev
apt-get update && apt-get install -y libssl-dev libz-dev

# install CMake 3.16
apt-get update && apt-get install -y curl
curl -L -o cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v3.16.1/cmake-3.16.1-Linux-x86_64.sh
sh cmake-linux.sh -- --skip-license --prefix=/usr

# install cross-compiler for Raspberry Pi
# (https://github.com/abhiTronix/raspberry-pi-cross-compilers)
mkdir -p ${CROSS_COMPILER_ROOT}
curl -L -o ${CROSS_COMPILER_PACKAGE_FILE} ${CROSS_COMPILER_BASE_URL}/${CROSS_COMPILER_RELATIVE_URL}
tar -xzf ${CROSS_COMPILER_PACKAGE_FILE} -C ${CROSS_COMPILER_ROOT} --strip-components 1
