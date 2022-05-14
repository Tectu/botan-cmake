# Overview

This repository provides `FindBotan.cmake` which allows for easily inclusion of Botan into CMake based projects.

Unlike other CMake integrations, this one does not simply add all the Botan files to a target. Instead, it does the following automagically:
1. Download the requested version of Botan.
2. Run Botan's python script to generate the amalgamation files `botan_all.h` and `botan_all.cpp`.
3. Provides a CMake target to compile & link those amalgamation files.

Refer Botan's [The Amalgamation Build](https://botan.randombit.net/handbook/building.html#amalgamation) documentation for more information on the amalgamation build.
