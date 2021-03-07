set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# get cross-compiler root directory from CROSS_COMPILER_ROOT environment variable
if (DEFINED ENV{CROSS_COMPILER_ROOT})
set(devel_root $ENV{CROSS_COMPILER_ROOT})
else()
message(FATAL_ERROR "❌ CROSS_COMPILER_ROOT environment variable not defined")
endif()

# get sysroot directory from SYSROOT_PREFIX environment variable
if (DEFINED ENV{SYSROOT_PREFIX})
    set(install_root $ENV{SYSROOT_PREFIX})
else()
    message(FATAL_ERROR "❌ SYSROOT_PREFIX environment variable not defined")
endif()

set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "armhf")
set(CMAKE_C_COMPILER ${devel_root}/bin/arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER ${devel_root}/bin/arm-linux-gnueabihf-g++)
set(CMAKE_CXX_FLAGS "-I${install_root}/include")
