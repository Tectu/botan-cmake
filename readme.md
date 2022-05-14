# Overview

This repository provides `FindBotan.cmake` which allows for easily inclusion of Botan into CMake based projects.

Unlike other CMake integrations for Botan, this one does not simply add all the Botan files to a target. Instead, it does the following automagically:
1. Download the requested version of Botan.
2. Run Botan's python script to generate the amalgamation files `botan_all.h` and `botan_all.cpp`.
3. Provides a CMake target to compile & link those amalgamation files.

Refer Botan's [The Amalgamation Build](https://botan.randombit.net/handbook/building.html#amalgamation) documentation for more information on the amalgamation build.


# Usage

To use this Botan CMake integration:
1. Download/copy `cmake/FindBotan.cmake` from this repository to your local CMake project.
2. Add that CMake script to your CMake module path (`CMAKE_MODULE_PATH`).
3. Use `find_package()` to "include" that CMake script in your project. Specify the components as needed.
4. Use `target_link_libraries()` to link to the generated CMake target.
5. Include `botan_all.h` where needed.

An example project is provided under `/example`.

Your `CMakeLists.txt`:
```cmake
find_package(
    botan 2.18.2
    COMPONENTS
        system_rng
        argon2
        sha3
    REQUIRED
)

target_link_libraries(
    MyTarget
    PRIVATE
        botan
)
```
