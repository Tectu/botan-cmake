##
## ToDo: A better approach would be to wrap most of this into a function like botan_generate(TARGET COMPONENTS) which
##       will create a target of name TARGET with the components COMPONENTS.
##       This way multiple targets can get different configurations.
##

cmake_minimum_required(VERSION 3.19)
include(FetchContent)

# Find python
find_package(
    Python
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
    botan_upstream
    URL ${DOWNLOAD_URL}
)
FetchContent_MakeAvailable(botan_upstream)

# Assemble value for --enable-modules parameter of configure.py
list(JOIN Botan_FIND_COMPONENTS "," ENABLE_MODULES_LIST)

# Run the configure.py script
add_custom_command(
    OUTPUT botan_all.cpp botan_all.h
    COMMENT "Generating Botan amalgamation files botan_all.cpp and botan_all.h"
    COMMAND ${Python_EXECUTABLE}
        ${botan_upstream_SOURCE_DIR}/configure.py
        --quiet
        --cc-bin=${CMAKE_CXX_COMPILER}
        --disable-shared
        --amalgamation
        --minimized-build
        --enable-modules=${ENABLE_MODULES_LIST}
)

# Heavy lifting by cmake
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Botan DEFAULT_MSG Botan_VERSION_STRING)

# Create target
set(TARGET_BOTAN botan)
if (NOT TARGET ${TARGET_BOTAN})
    add_library(${TARGET_BOTAN} STATIC)
endif()
target_sources(
    ${TARGET_BOTAN}
    PUBLIC
        ${CMAKE_CURRENT_BINARY_DIR}/botan_all.h
    PRIVATE
        ${CMAKE_CURRENT_BINARY_DIR}/botan_all.cpp
)
target_include_directories(
    ${TARGET_BOTAN}
    INTERFACE
        ${CMAKE_CURRENT_BINARY_DIR}
)
