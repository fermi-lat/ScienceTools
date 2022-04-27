# FindF2C.cmake
#
# Finds the F2C library
#
# This will define the following variables
#
# F2C_FOUND F2C_INCLUDE_DIRS F2C_LIBRARY
#
# along with the following input targets
#
# F2C::F2C
#
# Author: Alex Reustle - alexander.reustle@nasa.gov

# ##############################################################################
# Find the necessary headers and libraries
# ##############################################################################

find_path(
  F2C_INCLUDE_DIR
  REQUIRED
  NAMES f2c.h
  HINTS ${CMAKE_INSTALL_PREFIX}
  PATH_SUFFIXES f2c
)

find_library(
  F2C_LIBRARY
  NAMES f2c
  HINTS ${CMAKE_INSTALL_PREFIX}
  PATH_SUFFIXES lib lib64
)

# ##############################################################################
# Bookkeeping and warning if anything not found
mark_as_advanced(F2C_FOUND F2C_INCLUDE_DIR F2C_LIBRARY)
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(F2C REQUIRED_VARS F2C_INCLUDE_DIR F2C_LIBRARY)

# ##############################################################################
# Properly set variables and targets

# Set include dirs to parent, to enable includes like include
# <f2c/f2c.h>
if(F2C_FOUND)
  get_filename_component(F2C_INCLUDE_DIRS ${F2C_INCLUDE_DIR} DIRECTORY)
endif()

# Create the target and declare the target properties.
if(F2C_FOUND AND NOT TARGET F2C::F2C)
  add_library(F2C::F2C INTERFACE IMPORTED GLOBAL)
  target_include_directories(F2C::F2C INTERFACE "${F2C_INCLUDE_DIRS}")
  target_link_libraries(F2C::F2C INTERFACE "${F2C_LIBRARY}" m)
endif()
