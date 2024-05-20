# This module finds WCSlib, a library for managing World Coordinate Systems in astronomy.

# Set the minimum required version of CMake
cmake_minimum_required(VERSION 3.12)

# Optionally specify a minimum version of WCSlib
set(WCSLIB_MIN_VERSION "" CACHE STRING "Minimum required version of WCSlib")

# Search for the WCSlib headers
find_path(WCSLIB_INCLUDE_DIR
    NAMES wcslib/wcs.h
    PATHS ${WCSLIB_ROOT} ${WCSLIB_ROOT}/include
    PATH_SUFFIXES include
)

# Search for the WCSlib library
find_library(WCSLIB_LIBRARY
    NAMES wcs
    PATHS ${WCSLIB_ROOT} ${WCSLIB_ROOT}/lib
    PATH_SUFFIXES lib
)

# Handle standard CMake arguments with the found package
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(WCSlib
    FOUND_VAR WCSLIB_FOUND
    REQUIRED_VARS WCSLIB_LIBRARY WCSLIB_INCLUDE_DIR
)

# If both library and headers are found, define the WCSlib::WCSlib target
if(WCSLIB_FOUND)
    add_library(WCSlib::WCSlib UNKNOWN IMPORTED)
    set_target_properties(WCSlib::WCSlib PROPERTIES
        IMPORTED_LOCATION "${WCSLIB_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${WCSLIB_INCLUDE_DIR}"
    )
endif()

# Allow the user to specify the root directory of WCSlib as an advanced option
set(WCSLIB_ROOT "" CACHE PATH "Root directory of WCSlib installation")
mark_as_advanced(WCSLIB_LIBRARY WCSLIB_INCLUDE_DIR WCSLIB_ROOT)
