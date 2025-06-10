# ########################################################################### #
# Vendored Externals: Xerces-C
# ########################################################################### #

include(CheckFunctionExists)

message(STATUS "Local External Dependency Xerces-C")

# Set config options for Xerces-C, Backup existing cache values
if(DEFINED CACHE{BUILD_SHARED_LIBS})
  set(_xerces_backup_BUILD_SHARED_LIBS "${BUILD_SHARED_LIBS}")
endif()
if(DEFINED CACHE{network})
  set(_xerces_backup_network "${network}")
endif()

# Override options for Xerces-C
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(network OFF CACHE BOOL "Network support" FORCE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON CACHE BOOL "" FORCE)

# --- Wrapper to skip xercesc/{doc,tests,samples} --------------------------
# Save original function pointer
function(_safe_add_subdirectory dir)
    _original_add_subdirectory(${ARGV})
endfunction()

# Rename the built-in `add_subdirectory` to `_original_add_subdirectory`
cmake_policy(PUSH)
cmake_policy(SET CMP0057 NEW)  # Enables if() IN_LIST support
set(_add_subdirectory_func "add_subdirectory")
set(_original_add_subdirectory_func "_original_add_subdirectory")
get_property(_already_set GLOBAL PROPERTY _original_add_subdirectory_set SET)
if(NOT _already_set)
    set_property(GLOBAL PROPERTY _original_add_subdirectory_set TRUE)
    function(${_original_add_subdirectory_func})
        _add_subdirectory(${ARGV})
    endfunction()
endif()
cmake_policy(POP)

function(add_subdirectory dir)
    # Absolute path that was requested
    get_filename_component(_abs "${dir}" ABSOLUTE
                            BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
    # Directory three we want to ignore inside xerces-c
    set(_skip_list
        "${CMAKE_SOURCE_DIR}/externals/xercesc/xercesc/doc"
        "${CMAKE_SOURCE_DIR}/externals/xercesc/xercesc/tests"
        "${CMAKE_SOURCE_DIR}/externals/xercesc/xercesc/samples"
    )
    list(FIND _skip_list "${_abs}" _skip_index)

    if(_skip_index EQUAL -1)
        _original_add_subdirectory(${ARGV})
    else()
        message(STATUS "Skipping xerces-c optional directory: ${dir}")
    endif()
endfunction()
# --------------------------------------------------------------------------

add_subdirectory(xercesc) # <-- doc, tests, and samples are ignored

# --------------------------------------------------------------------------
unset(add_subdirectory)

if(DEFINED _xerces_backup_BUILD_SHARED_LIBS )
  set(BUILD_SHARED_LIBS "${_xerces_backup_BUILD_SHARED_LIBS}" CACHE BOOL "" FORCE)
  unset(_xerces_backup_BUILD_SHARED_LIBS)
endif()
if(DEFINED _xerces_backup_network )
  set(network "${_xerces_backup_network}" CACHE BOOL "" FORCE)
  unset(_xerces_backup_network)
endif()

add_library(XercesC::XercesC ALIAS xerces-c)
