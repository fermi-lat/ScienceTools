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

project(healpix_cxx_src-populate NONE)



include(ExternalProject)
ExternalProject_Add(healpix_cxx_src-populate
                     "UPDATE_DISCONNECTED" "False" "DOWNLOAD_EXTRACT_TIMESTAMP" "TRUE" "EXTERNALPROJECT_INTERNAL_ARGUMENT_SEPARATOR" "URL" "https://downloads.sourceforge.net/project/healpix/Healpix_3.31/Healpix_3.31_2016Aug26.tar.gz" "URL_HASH" "SHA256=ddf437442b6d5ae7d75c9afaafc4ec43921f903c976e25db3c5ed5185a181542" "PATCH_COMMAND" "patch" "-p0" "<" "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/externals/healpix_cxx/healpix_cxx.patch"
                    SOURCE_DIR          "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/healpix_cxx_src-src"
                    BINARY_DIR          "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/healpix_cxx_src-build"
                    CONFIGURE_COMMAND   ""
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    TEST_COMMAND        ""
                    USES_TERMINAL_DOWNLOAD  YES
                    USES_TERMINAL_UPDATE    YES
                    USES_TERMINAL_PATCH     YES
)


