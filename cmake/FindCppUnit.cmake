# This module tries to find CppUnit libraries and headers

# Set a minimum required version for CMake
cmake_minimum_required(VERSION 3.12)

# Try to find the CppUnit headers
find_path(CPPUNIT_INCLUDE_DIR
    NAMES cppunit/TestCase.h
    PATHS ${CPPUNIT_ROOT} ${CPPUNIT_ROOT}/include
    PATH_SUFFIXES include
)

# Try to find the CppUnit library
find_library(CPPUNIT_LIBRARY
    NAMES cppunit
    PATHS ${CPPUNIT_ROOT} ${CPPUNIT_ROOT}/lib
    PATH_SUFFIXES lib
)

# Handle standard CMake arguments with the found package
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CppUnit
    FOUND_VAR CPPUNIT_FOUND
    REQUIRED_VARS CPPUNIT_LIBRARY CPPUNIT_INCLUDE_DIR
)

# If both library and headers are found, define the CppUnit::CppUnit target
if(CPPUNIT_FOUND)
    add_library(CppUnit::CppUnit UNKNOWN IMPORTED)
    set_target_properties(CppUnit::CppUnit PROPERTIES
        IMPORTED_LOCATION "${CPPUNIT_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${CPPUNIT_INCLUDE_DIR}"
    )
endif()

# Allow the user to specify the root directory of CppUnit as an advanced option
set(CPPUNIT_ROOT "" CACHE PATH "Root directory of CppUnit installation")
mark_as_advanced(CPPUNIT_LIBRARY CPPUNIT_INCLUDE_DIR CPPUNIT_ROOT)

