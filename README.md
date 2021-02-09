# gRPC builds

This repository provides packages containing binaries and development files for [gRPC](https://github.com/grpc/grpc) (an open source and high-performance RPC library and framework) and [Protobuf compilers](https://github.com/protocolbuffers/protobuf), for Linux x64 (`amd64`) and ARM (`armhf`) architectures. These packages are built from the official source of gRPC and its dependencies, using GitHub Actions.

This project was created to compile applications on Raspberry Pi that need up-to-date versions of gRPC for Raspberry Pi, avoiding lengthy compilations of gRPC on the Pi.

The x64 builds are a by-product of the overall build process, which involves cross-compiling for ARM, which in turn requires gRPC's `protoc` and `grpc_cpp_plugin` binaries to be available on the host (x64) system where the cross-compilation is taking place.



The main assets, which can be found in the [Releases](https://github.com/spujadas/grpc-builds/releases) section, are:

- `grpc_*_amd64.deb` — Debian package of gRPC and Protobuf compilers for x64 Linux (), containing binaries and development files, which will be installed in `/usr/local`.
- `grpc-*-amd64.tar.gz` — Compressed archive of gRPC for x64 Linux, with the same contents as the previous package, and designed to be installed in `/usr/local`.
- `grpc_*_armhf.deb` — Debian package of gRPC for ARM Linux, containing binaries and development files, which will be installed in `/usr/local`.
- `grpc-*-armhf.tar.gz` — Compressed archive of gRPC for ARM Linux, with the same contents as the previous package, and designed to be installed in `/usr/local`.



The following artefacts are also available under Releases:

- `grpc_sysroot-*-armhf.tar.gz` — Compressed archive of gRPC for ARM Linux containing binaries and development files for cross-compilation purposes. The contents are designed to be installed in `/tmp/raspberrypi_root`. Cross-compilation will require development files for zlib for ARM (see next point).
- `zlib_sysroot-*-armhf.tar.gz` — Compressed archive of [zlib](https://github.com/madler/zlib) for ARM Linux containing binaries and development files for cross-compilation purposes. The contents are designed to be installed in `/tmp/raspberrypi_root`.
- `zlib_*_armhf.deb` and `zlib-*-armhf.tar.gz` — Debian package and compressed archive of zlib for ARM Linux, containing binaries and development files, to be installed in `/usr/local`. *These files are generated as part of the build process, but they shouldn't be needed in general as all Linux distributions have official zlib packages.*



### Build

The assets and artefacts are automatically built by GitHub Actions, but if you want to build them yourself, for instance to tinker with the build scripts, then you can run the build scripts one after the other, as follows (mind the extra `.` before the scripts that set environment variables):

```
. ./01_set_env_vars_common_grpc.sh
./02_checkout_grpc.sh
. ./03_set_env_vars_zlib.sh
./04_install_prerequisites.sh
./05_build_grpc_amd64.sh
./06_install_grpc_amd64.sh
./07_build_zlib_armhf.sh
./08_install_zlib_sysroot.sh
./09_build_grpc_armhf.sh
```

The resulting packages will be created in the current directory.



### Alternatives

Your x64 or ARM Linux distribution may have official packages of gRPC binaries, development files, and dependencies, e.g. for Ubuntu: `libgrpc6`, `libgrpc++1`, `libgrpc-dev`, `libgrpc++-dev`, `protobuf-compiler` (provides `protoc`), `protobuf-compiler-grpc` (provides `grpc_*_plugin`).

You may also follow the [official build instructions for gRPC C++](https://github.com/grpc/grpc/blob/master/BUILDING.md) to build gRPC yourself.



### About

Written by [Sébastien Pujadas](https://pujadas.net/), released under the [Apache 2.0 license](https://github.com/spujadas/grpc-build/blob/master/LICENSE).

This repository was originally created to make it easier to build and package the author's [departure board virtual and physical (LED matrix) board servers](https://github.com/spujadas/departure-board-servers-cpp).