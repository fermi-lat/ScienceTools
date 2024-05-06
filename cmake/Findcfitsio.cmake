# FindCFITSIO.cmake
# 
# This script provides the cfitsio library as an imported target cfitsio::cfitsio.
# It supports version specification.
#
# Author: Alexander Reustle - 2024

# Define the minimum required version of CMake
cmake_minimum_required(VERSION 3.12)

# Provide the project name and language
project(FindCFITSIO NONE)

# Check if a specific version was requested.
if(NOT cfitsio_FIND_VERSION)
  set(cfitsio_FIND_VERSION "")
endif()

# Search for the cfitsio headers
find_path(CFITSIO_INCLUDE_DIR
    NAMES fitsio.h
    PATH_SUFFIXES cfitsio
)

# Search for the cfitsio library
find_library(CFITSIO_LIBRARY
    NAMES cfitsio
    PATH_SUFFIXES lib
)

# Try to find CURL which is a transitive dependency
find_package(CURL REQUIRED)

# If a header is found, try to extract the version number from it
if(CFITSIO_INCLUDE_DIR)
    file(STRINGS "${CFITSIO_INCLUDE_DIR}/fitsio.h" CFITSIO_VERSION_DEFINE
         REGEX "#define CFITSIO_VERSION [0-9]+")
    if(CFITSIO_VERSION_DEFINE)
        string(REGEX REPLACE "#define CFITSIO_VERSION ([0-9]+)" "\\1" CFITSIO_VERSION ${CFITSIO_VERSION_DEFINE})
    endif()
endif()

# Include standard handle args with version support
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(cfitsio
    FOUND_VAR CFITSIO_FOUND
    REQUIRED_VARS CFITSIO_LIBRARY CFITSIO_INCLUDE_DIR
    VERSION_VAR CFITSIO_VERSION
)

# If the library is found and versions match, define the cfitsio::cfitsio target
# Link CURL as a transitive dependency
if(CFITSIO_FOUND AND (CFITSIO_VERSION VERSION_GREATER_EQUAL cfitsio_FIND_VERSION))
    add_library(cfitsio::cfitsio UNKNOWN IMPORTED)
    set_target_properties(cfitsio::cfitsio PROPERTIES
        IMPORTED_LOCATION "${CFITSIO_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${CFITSIO_INCLUDE_DIR}"
        INTERFACE_LINK_LIBRARIES "${CURL_LIBRARIES}"
    )

    # Link CURL as a transitive dependency
    set_property(TARGET cfitsio::cfitsio APPEND PROPERTY INTERFACE_LINK_LIBRARIES "${CURL_LIBRARIES}")
    set_property(TARGET cfitsio::cfitsio APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES "${CURL_INCLUDE_DIRS}")
endif()

# Expose advanced variables to the user if needed
mark_as_advanced(CFITSIO_LIBRARY CFITSIO_INCLUDE_DIR CURL_LIBRARIES CURL_INCLUDE_DIRS)
