#!/bin/bash

# install prerequisites

# check required environment variables
source utils.sh
check_env_var CROSS_COMPILER_ROOT
check_env_var CROSS_COMPILER_RELATIVE_URL

set -ex

# install libssl-dev and libz-dev
sudo apt update
sudo apt install -y libssl-dev zlib1g-dev

# install cURL
sudo apt install -y curl

# install CMake 3.16
if [ ! -f /usr/bin/cmake ]; then
    curl -L -o cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v3.16.1/cmake-3.16.1-Linux-x86_64.sh
    sudo sh cmake-linux.sh -- --skip-license --prefix=/usr
fi

# install cross-compiler for Raspberry Pi
# (https://github.com/abhiTronix/raspberry-pi-cross-compilers)
mkdir -p ${CROSS_COMPILER_ROOT}

if [ ! -f ${CROSS_COMPILER_PACKAGE_FILE} ]; then
    curl -L -o ${CROSS_COMPILER_PACKAGE_FILE} ${CROSS_COMPILER_BASE_URL}/${CROSS_COMPILER_RELATIVE_URL}
fi
tar -xzf ${CROSS_COMPILER_PACKAGE_FILE} -C ${CROSS_COMPILER_ROOT} --strip-components 1

# install prerequisite build tools and dev packages
sudo apt install make g++
