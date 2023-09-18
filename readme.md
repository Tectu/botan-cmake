# Overview

This repository provides `FindBotan.cmake` which allows for easily inclusion of Botan into CMake based projects.

Unlike other CMake integrations for Botan, this one does not simply add all the Botan files to a target. Instead, it does the following automagically:
1. Download the requested version of Botan (if not provided locally).
2. Run Botan's python script to generate the amalgamation files `botan_all.h` and `botan_all.cpp`.
3. Provides a CMake target to compile & link those amalgamation files.

Refer to Botan's [The Amalgamation Build](https://botan.randombit.net/handbook/building.html#amalgamation) documentation for more information on the amalgamation build.


# Licensing

Code provided by this repository is considered to be public domain using the [Unlicense](https://unlicense.org/) license.
However, note that Botan ships with its own licensing.


# Usage

To use this Botan CMake integration:
1. Download/copy `cmake/FindBotan.cmake` from this repository to your local CMake project.
2. Add that CMake script to your CMake module path (`CMAKE_MODULE_PATH`).
3. Use `find_package()` to "include" that CMake script in your project. Do not specify any components.
4. Use the `botan_generate()` function to generate a target with specific Botan modules enabled.
5. Use `target_link_libraries()` to link to the generated CMake target.
6. Include `botan_all.h` where needed.

An example project is provided under `/example`.

Your `CMakeLists.txt`:
```cmake
# Find Botan
find_package(
    botan 2.18.2
    REQUIRED
)

# Create target "botan_test" with modules "system_rng" and "sha3" enabled
botan_generate(
    botan_test
        system_rng
        sha3
)

# Link to generated target
target_link_libraries(
    MyTarget
    PRIVATE
        botan_test
)
```

## Local Botan distribution

By default, this CMake module will download the Botan upstream distribution tarball. If this is undesired, a path to a
local copy of the tarball can be supplied via the `Botan_PATH` variable.
