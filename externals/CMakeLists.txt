# ########################################################################### #
# Vendored Externals
# ########################################################################### #

cmake_minimum_required(VERSION 3.14)
cmake_policy(SET CMP0120 NEW)
set(CMAKE_POLICY_VERSION_MINIMUM 3.10)
include(ExternalProject)

# =========================================================================== #
# cfitsio
# =========================================================================== #

# Set config options for CFITSIO
# Backup existing cache values
foreach(_var IN ITEMS USE_CURL BUILD_SHARED_LIBS TESTS)
if(DEFINED CACHE{${_var}})
  set(_cfitsio_backup_${_var} "${${_var}}")
endif()
endforeach()

# Override options for CFITSIO
set(USE_CURL OFF CACHE BOOL "" FORCE)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(TESTS OFF CACHE BOOL "" FORCE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON CACHE BOOL "" FORCE)

add_subdirectory(cfitsio)

# Restore original values
foreach(_var IN ITEMS USE_CURL USE_BZIP2 BUILD_SHARED_LIBS TESTS)
if(DEFINED _cfitsio_backup_${_var})
  set(${_var} "${_cfitsio_backup_${_var}}" CACHE BOOL "" FORCE)
  unset(_cfitsio_backup_${_var})
else()
  unset(${_var} CACHE)
endif()
endforeach()

add_library(cfitsio::cfitsio ALIAS cfitsio)

# =========================================================================== #
# CLHEP – granular static libraries, namespaced targets                       #
# =========================================================================== #
include(ExternalProject)

set(_clhep_src       ${CMAKE_SOURCE_DIR}/externals/clhep)
set(_clhep_install   ${CMAKE_BINARY_DIR}/externals/clhep/install)

file(STRINGS "${_clhep_src}/CMakeLists.txt" _clhep_ver_line
     REGEX "^project\\(CLHEP VERSION [0-9.]+")
string(REGEX REPLACE ".*VERSION ([0-9.]+).*" "\\1" _clhep_ver "${_clhep_ver_line}")

message(STATUS "CLHEP version detected: ${_clhep_ver}")

ExternalProject_Add(clhep_external
  SOURCE_DIR          ${_clhep_src}
  UPDATE_COMMAND      "" # never auto-update the pinned commit
  INSTALL_DIR         ${_clhep_install}

  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${_clhep_install}
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    -DBUILD_SHARED_LIBS=OFF
    -DBUILD_TESTING=OFF
    -DBUILD_EXAMPLES=OFF
)

# ----------------------------------------------------------------------------
# Helper macro to declare one imported interface target that points at
# libCLHEP-<Pkg>.a in the local install tree.
# ----------------------------------------------------------------------------
function(_clhep_make_target pkg)
  string(TOLOWER "${pkg}" _lc_pkg)          # for the library file name
  add_library(clhep_${_lc_pkg}_static INTERFACE)

  # All granular static libs are named libCLHEP-<Package>.a
  # set(_lib "${_clhep_install}/lib/libCLHEP-${pkg}.a")
  set(_lib "${_clhep_install}/lib/libCLHEP-${pkg}-${_clhep_ver}.a")
  set(_incs "${_clhep_install}/include")

  add_dependencies(clhep_${_lc_pkg}_static clhep_external)
  target_include_directories(clhep_${_lc_pkg}_static INTERFACE "${_incs}")
  target_link_libraries      (clhep_${_lc_pkg}_static INTERFACE "${_lib}")

  # Namespaced alias the rest of the project will use
  add_library(CLHEP::${pkg} ALIAS clhep_${_lc_pkg}_static)
  add_library(CLHEP::${pkg}S ALIAS clhep_${_lc_pkg}_static)
endfunction()

# Declare only the packages you actually need
foreach(_pkg IN ITEMS Units Utility Vector Geometry Random Matrix)
  _clhep_make_target(${_pkg})
endforeach()
