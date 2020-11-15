# gRPC builds

This repository provides packages containing binaries and development files for [gRPC](https://github.com/grpc/grpc) (an open source and high-performance RPC library and framework) and [Protobuf compilers](https://github.com/protocolbuffers/protobuf), for Linux x64 (`amd64`) and ARM (`armhf`) architectures. These packages are built from the official source of gRPC and its dependencies, using GitHub Actions.

This project was created to compile applications on Raspberry Pi that need up-to-date versions of gRPC for Raspberry Pi, avoiding lengthy compilations of gRPC on the Pi.

The x64 builds are a by-product of the overall build process, which involves cross-compiling for ARM, which in turn requires gRPC's `protoc` and `grpc_cpp_plugin` binaries to be available on the host (x64) system where the cross-compilation is taking place.



The main assets, which can be found in the [Releases](https://github.com/spujadas/grpc-builds/releases) section, are:

- A Debian package of gRPC and Protobuf compilers for x64 Linux (`grpc_*_amd64.deb`), containing binaries and development files, which will be installed in `/usr/local`.
- A compressed archive of gRPC for x64 Linux (`grpc-*-amd64.tar.gz`), with the same contents as the previous package, and designed to be installed in `/usr/local`.
- A Debian package of gRPC for ARM Linux (`grpc_*_armhf.deb`), containing binaries and development files, which will be installed in `/usr/local`.
- A compressed archive of gRPC for ARM Linux (`grpc-*-armhf.tar.gz`), with the same contents as the previous package, and designed to be installed in `/usr/local`.



The following artefacts are also available under Releases:

- A compressed archive of gRPC for ARM Linux (`grpc_sysroot-*-armhf.tar.gz`) containing binaries and development files for cross-compilation purposes. The contents are designed to be installed in `/tmp/raspberrypi_root`. Cross-compilation will require development files for zlib for ARM (see next point).
- A compressed archive of [zlib](https://github.com/madler/zlib) for ARM Linux (`zlib_sysroot-*-armhf.tar.gz`) containing binaries and development files for cross-compilation purposes. The contents are designed to be installed in `/tmp/raspberrypi_root`.
- A Debian package (`zlib_*_armhf.deb`) and a compressed archive (`zlib-*-armhf.tar.gz`) of zlib for ARM Linux, containing binaries and development files, to be installed in `/usr/local`. This package shouldn't be needed in general as all Linux distributions have official zlib packages.



### Alternatives

Your x64 or ARM Linux distribution may have official packages of gRPC binaries, development files, and dependencies, e.g. for Ubuntu: `libgrpc6`, `libgrpc++1`, `libgrpc-dev`, `libgrpc++-dev`, `protobuf-compiler` (provides `protoc`), `protobuf-compiler-grpc` (provides `grpc_*_plugin`).

You may also follow the [official build instructions for gRPC C++](https://github.com/grpc/grpc/blob/master/BUILDING.md) to build gRPC yourself.



### About

Written by [Sébastien Pujadas](https://pujadas.net/), released under the [Apache 2.0 license](https://github.com/spujadas/grpc-build/blob/master/LICENSE).

This repository was originally created to make it easier to build and package the author's [departure board virtual and physical (LED matrix) board servers](https://github.com/spujadas/departure-board-servers-cpp).