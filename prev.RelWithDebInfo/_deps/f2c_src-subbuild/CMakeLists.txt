# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 4.4.2)

# Reject any attempt to use a toolchain file. We must not use one because
# we could be downloading it here. If the CMAKE_TOOLCHAIN_FILE environment
# variable is set, the cache variable will have been initialized from it.
unset(CMAKE_TOOLCHAIN_FILE CACHE)
unset(ENV{CMAKE_TOOLCHAIN_FILE})

# We name the project and the target for the ExternalProject_Add() call
# to something that will highlight to the user what we are working on if
# something goes wrong and an error message is produced.

project(f2c_src-populate NONE)



include(ExternalProject)
ExternalProject_Add(f2c_src-populate
                     "UPDATE_DISCONNECTED" "False" "DOWNLOAD_EXTRACT_TIMESTAMP" "TRUE" "EXTERNALPROJECT_INTERNAL_ARGUMENT_SEPARATOR" "URL" "https://web.archive.org/web/20210322095636/https://netlib.sandia.gov/f2c/libf2c.zip" "URL_HASH" "SHA256=ca404070e9ce0a9aaa6a71fc7d5489d014ade952c5d6de7efb88de8e24f2e8e0" "PATCH_COMMAND" "patch" "<" "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/externals/f2c/f2c.patch"
                    SOURCE_DIR          "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/f2c_src-src"
                    BINARY_DIR          "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/f2c_src-build"
                    CONFIGURE_COMMAND   ""
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    TEST_COMMAND        ""
                    USES_TERMINAL_DOWNLOAD  YES
                    USES_TERMINAL_UPDATE    YES
                    USES_TERMINAL_PATCH     YES
)


