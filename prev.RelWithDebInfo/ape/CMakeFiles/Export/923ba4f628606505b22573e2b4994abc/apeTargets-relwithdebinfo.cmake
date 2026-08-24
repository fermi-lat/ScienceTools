#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "ST::ape" for configuration "RelWithDebInfo"
set_property(TARGET ST::ape APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(ST::ape PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libape_3.dylib"
  IMPORTED_SONAME_RELWITHDEBINFO "@rpath/libape_3.dylib"
  )

list(APPEND _cmake_import_check_targets ST::ape )
list(APPEND _cmake_import_check_files_for_ST::ape "${_IMPORT_PREFIX}/lib/libape_3.dylib" )

# Import target "ST::pcheck" for configuration "RelWithDebInfo"
set_property(TARGET ST::pcheck APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(ST::pcheck PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/pcheck"
  )

list(APPEND _cmake_import_check_targets ST::pcheck )
list(APPEND _cmake_import_check_files_for_ST::pcheck "${_IMPORT_PREFIX}/bin/pcheck" )

# Import target "ST::pget" for configuration "RelWithDebInfo"
set_property(TARGET ST::pget APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(ST::pget PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/pget"
  )

list(APPEND _cmake_import_check_targets ST::pget )
list(APPEND _cmake_import_check_files_for_ST::pget "${_IMPORT_PREFIX}/bin/pget" )

# Import target "ST::plist" for configuration "RelWithDebInfo"
set_property(TARGET ST::plist APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(ST::plist PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/plist"
  )

list(APPEND _cmake_import_check_targets ST::plist )
list(APPEND _cmake_import_check_files_for_ST::plist "${_IMPORT_PREFIX}/bin/plist" )

# Import target "ST::pquery" for configuration "RelWithDebInfo"
set_property(TARGET ST::pquery APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(ST::pquery PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/pquery"
  )

list(APPEND _cmake_import_check_targets ST::pquery )
list(APPEND _cmake_import_check_files_for_ST::pquery "${_IMPORT_PREFIX}/bin/pquery" )

# Import target "ST::pquery2" for configuration "RelWithDebInfo"
set_property(TARGET ST::pquery2 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(ST::pquery2 PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/pquery2"
  )

list(APPEND _cmake_import_check_targets ST::pquery2 )
list(APPEND _cmake_import_check_files_for_ST::pquery2 "${_IMPORT_PREFIX}/bin/pquery2" )

# Import target "ST::pset" for configuration "RelWithDebInfo"
set_property(TARGET ST::pset APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(ST::pset PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/pset"
  )

list(APPEND _cmake_import_check_targets ST::pset )
list(APPEND _cmake_import_check_files_for_ST::pset "${_IMPORT_PREFIX}/bin/pset" )

# Import target "ST::punlearn" for configuration "RelWithDebInfo"
set_property(TARGET ST::punlearn APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(ST::punlearn PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/punlearn"
  )

list(APPEND _cmake_import_check_targets ST::punlearn )
list(APPEND _cmake_import_check_files_for_ST::punlearn "${_IMPORT_PREFIX}/bin/punlearn" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
