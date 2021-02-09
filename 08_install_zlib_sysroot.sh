#!/bin/bash

# install zlib in sysroot


# check required environment variables
source utils.sh
check_env_var ZLIB_SYSROOT_PACKAGE_NAME
check_env_var SYSROOT_PREFIX

set -ex

# create sysroot dir as required
mkdir -p ${SYSROOT_PREFIX}

# install
## strip components: in archive, files are in zlib_sysroot-1.2.11-armhf/tmp/raspberrypi_root
tar xvzf ${ZLIB_SYSROOT_PACKAGE_NAME}.tar.gz -C ${SYSROOT_PREFIX} --strip-components 3
