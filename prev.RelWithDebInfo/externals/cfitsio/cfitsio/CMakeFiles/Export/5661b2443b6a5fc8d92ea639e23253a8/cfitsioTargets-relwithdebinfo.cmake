#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "CFITSIO::cfitsio" for configuration "RelWithDebInfo"
set_property(TARGET CFITSIO::cfitsio APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(CFITSIO::cfitsio PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "C"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libcfitsio.a"
  )

list(APPEND _cmake_import_check_targets CFITSIO::cfitsio )
list(APPEND _cmake_import_check_files_for_CFITSIO::cfitsio "${_IMPORT_PREFIX}/lib/libcfitsio.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
