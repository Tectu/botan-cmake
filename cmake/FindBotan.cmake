cmake_minimum_required(VERSION 3.19)

include(FetchContent)

# Find python
find_package(
    Python3
    COMPONENTS
        Interpreter
    REQUIRED
)

# Assemble version string
set(Botan_VERSION_STRING ${Botan_FIND_VERSION_MAJOR}.${Botan_FIND_VERSION_MINOR}.${Botan_FIND_VERSION_PATCH})

# Assemble download URL
set(DOWNLOAD_URL https://github.com/randombit/botan/archive/refs/tags/${Botan_VERSION_STRING}.tar.gz)

# Just do a dummy download to see whether we can download the tarball
file(
    DOWNLOAD
    ${DOWNLOAD_URL}
    STATUS download_status
)
if (NOT download_status EQUAL 0)
    message(FATAL_ERROR "Could not download Botan tarball (status = ${download_status}): ${DOWNLOAD_URL}")
endif()

# Download the tarball
FetchContent_Declare(
    Botan-Upstream
    URL ${DOWNLOAD_URL}
)
FetchContent_GetProperties(Botan-Upstream)
if(NOT Botan-Upstream_POPULATED)
    FetchContent_Populate(Botan-Upstream)
endif()

# Run the configure.py script
add_custom_command(
    OUTPUT botan_all.cpp botan_all.h
    COMMENT "Generating Botan amalgamation files botan_all.cpp and botan_all.h"
    COMMAND foo
)

# Heavy lifting by cmake
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Botan DEFAULT_MSG Botan_VERSION_STRING)

# Create target
set(TARGET_BOTAN Botan)
if (NOT TARGET ${TARGET_BOTAN})
    add_library(${TARGET_BOTAN} INTERFACE IMPORTED)
endif()
target_sources(
    ${TARGET_BOTAN}
    INTERFACE
        botan_all.cpp
        botan_all.h
)
