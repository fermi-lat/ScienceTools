#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "FermiMinuit2::FermiMinuit2Math" for configuration "RelWithDebInfo"
set_property(TARGET FermiMinuit2::FermiMinuit2Math APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(FermiMinuit2::FermiMinuit2Math PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libFermiMinuit2Math.a"
  )

list(APPEND _cmake_import_check_targets FermiMinuit2::FermiMinuit2Math )
list(APPEND _cmake_import_check_files_for_FermiMinuit2::FermiMinuit2Math "${_IMPORT_PREFIX}/lib/libFermiMinuit2Math.a" )

# Import target "FermiMinuit2::FermiMinuit2" for configuration "RelWithDebInfo"
set_property(TARGET FermiMinuit2::FermiMinuit2 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(FermiMinuit2::FermiMinuit2 PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libFermiMinuit2.a"
  )

list(APPEND _cmake_import_check_targets FermiMinuit2::FermiMinuit2 )
list(APPEND _cmake_import_check_files_for_FermiMinuit2::FermiMinuit2 "${_IMPORT_PREFIX}/lib/libFermiMinuit2.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
