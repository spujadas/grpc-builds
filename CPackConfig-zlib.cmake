set(CPACK_PACKAGE_NAME "zlib")

set(CPACK_PACKAGE_DESCRIPTION "compression library - runtime and development")
set(PACKAGE_LONG_DESCRIPTION "zlib is a library implementing the deflate compression method found in gzip and PKZIP.  This package includes the shared library and the development support files.")

set(CPACK_CMAKE_GENERATOR "Unix Makefiles")

set(CPACK_GENERATOR "DEB;TGZ")

#set(CPACK_DEBIAN_FILE_NAME "DEB-DEFAULT")  # built from CPACK_PACKAGE_NAME, CPACK_PACKAGE_VERSION, CPACK_DEBIAN_PACKAGE_ARCHITECTURE, CPACK_DEBIAN_PACKAGE_RELEASE
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Sébastien Pujadas <sebastien@pujadas.net>")
set(CPACK_DEBIAN_PACKAGE_DESCRIPTION
  "${CPACK_PACKAGE_DESCRIPTION}\n ${PACKAGE_LONG_DESCRIPTION}")
set(CPACK_DEBIAN_PACKAGE_CONFLICTS "zlib1 zlib1-dev zlib1g zlib1g-dev")
set(CPACK_DEBIAN_PACKAGE_PROVIDES "libz1 libz-dev")
