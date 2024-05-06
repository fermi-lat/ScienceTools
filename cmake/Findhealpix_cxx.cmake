# This module attempts to find the HEALPix C++ library.

# Set the minimum required version of CMake
cmake_minimum_required(VERSION 3.12)

# Define the project for this find module
project(Findhealpix_cxx)

# Search for HEALPix C++ headers
find_path(HEALPIX_CXX_INCLUDE_DIR
    NAMES healpix_base.h
    PATHS ${HEALPIX_CXX_ROOT} ${HEALPIX_CXX_ROOT}/include ${HEALPIX_CXX_ROOT}/include/healpix_cxx
    PATH_SUFFIXES healpix_cxx
)

# Search for the HEALPix C++ library
find_library(HEALPIX_CXX_LIBRARY
    NAMES healpix_cxx
    PATHS ${HEALPIX_CXX_ROOT} ${HEALPIX_CXX_ROOT}/lib
    PATH_SUFFIXES lib
)

# Handle standard CMake arguments with the found package
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(healpix_cxx
    FOUND_VAR HEALPIX_CXX_FOUND
    REQUIRED_VARS HEALPIX_CXX_LIBRARY HEALPIX_CXX_INCLUDE_DIR
)

# If both library and headers are found, define the healpix_cxx::healpix_cxx target
if(HEALPIX_CXX_FOUND)
    add_library(healpix_cxx::healpix_cxx UNKNOWN IMPORTED)
    set_target_properties(healpix_cxx::healpix_cxx PROPERTIES
        IMPORTED_LOCATION "${HEALPIX_CXX_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${HEALPIX_CXX_INCLUDE_DIR}"
    )
endif()

# Allow the user to specify the root directory of HEALPix C++ as an advanced option
set(HEALPIX_CXX_ROOT "" CACHE PATH "Root directory of HEALPix C++ installation")
mark_as_advanced(HEALPIX_CXX_LIBRARY HEALPIX_CXX_INCLUDE_DIR HEALPIX_CXX_ROOT)
