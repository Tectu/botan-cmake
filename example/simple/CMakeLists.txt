list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../cmake)

find_package(
    Botan 3.4.0
    REQUIRED
)

# Generate target 'botan_test' with specific modules
botan_generate(
    botan_test
        system_rng
        sha3
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
        botan_test
)
