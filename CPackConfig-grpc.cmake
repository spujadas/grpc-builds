set(CPACK_PACKAGE_NAME "gRPC")

set(CPACK_PACKAGE_DESCRIPTION "high performance general RPC framework")
set(PACKAGE_LONG_DESCRIPTION "gRPC enables client and server applications to communicate transparently, and simplifies the building of connected systems.")

set(CPACK_CMAKE_GENERATOR "Unix Makefiles")

set(CPACK_GENERATOR "DEB;TGZ")

#set(CPACK_DEBIAN_FILE_NAME "DEB-DEFAULT")  # built from CPACK_PACKAGE_NAME, CPACK_PACKAGE_VERSION, CPACK_DEBIAN_PACKAGE_ARCHITECTURE, CPACK_DEBIAN_PACKAGE_RELEASE
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Sébastien Pujadas <sebastien@pujadas.net>")
set(CPACK_DEBIAN_PACKAGE_DESCRIPTION
  "${CPACK_PACKAGE_DESCRIPTION}\n ${PACKAGE_LONG_DESCRIPTION}")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "libz-dev")
set(CPACK_DEBIAN_PACKAGE_CONFLICTS "libgrpc++-dev libgrpc++1 libgrpc-dev libgrpc6")
