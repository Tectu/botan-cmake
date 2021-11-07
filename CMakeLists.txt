cmake_minimum_required(VERSION 3.19)
project(botan_cmake)

set(CMAKE_CXX_STANDARD 20)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

find_package(
    Botan 2.18.2
    COMPONENTS
        system_rng
        argon2
        sha3
    REQUIRED
)

set(TARGET botan-cmake-demo)
add_executable(${TARGET})

target_sources(
    ${TARGET}
    PRIVATE
        main.cpp
)

target_link_libraries(
    ${TARGET}
    PRIVATE
        botan
)
