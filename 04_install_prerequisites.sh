#!/bin/bash

# install prerequisites

# check required environment variables
source utils.sh
check_env_var CROSS_COMPILER_INSTALL_DIR
check_env_var CROSS_COMPILER_GIT_REPOSITORY

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
git clone ${CROSS_COMPILER_GIT_REPOSITORY} ${CROSS_COMPILER_INSTALL_DIR}

# install prerequisite build tools and dev packages
sudo apt install make g++
