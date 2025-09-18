# =========================================================================== #
# FFTW 3.3.10
# =========================================================================== #

message(STATUS "Local External Dependency FFTW3")

# Cache original values
foreach(_var IN ITEMS 
    CMAKE_POSITION_INDEPENDENT_CODE BUILD_SHARED_LIBS TESTS ENABLE_THREADS
    #CMAKE_C_FLAGS ENABLE_DOUBLE ENABLE_SSE ENABLE_SSE2 ENABLE_AVX ENABLE_AVX2 )
    CMAKE_C_FLAGS ENABLE_DOUBLE ENABLE_SSE ENABLE_SSE2 ENABLE_AVX )
if(DEFINED CACHE{${_var}})                 
  set(_fftw_backup_${_var} "${${_var}}")   
endif()
endforeach()

set(CMAKE_POSITION_INDEPENDENT_CODE ON CACHE BOOL "" FORCE)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(ENABLE_THREADS ON CACHE BOOL "" FORCE)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -fomit-frame-pointer -fstrict-aliasing -ffast-math" CACHE STRING "" FORCE)
set(ENABLE_DOUBLE ON CACHE BOOL "" FORCE)
set(ENABLE_SSE ON CACHE BOOL "" FORCE)
set(ENABLE_SSE2 ON CACHE BOOL "" FORCE)
set(ENABLE_AVX ON CACHE BOOL "" FORCE)
#set(ENABLE_AVX2 ON CACHE BOOL "" FORCE)

target_include_directories(fftw3 INTERFACE 
    "$<INSTALL_INTERFACE:include>"
    "$<BUILD_INTERFACE:${fftw_SOURCE_DIR}/api>")

add_library(FFTW::fftw3 ALIAS fftw3)

# Restore original values
foreach(_var IN ITEMS 
    CMAKE_POSITION_INDEPENDENT_CODE BUILD_SHARED_LIBS TESTS ENABLE_THREADS
    #CMAKE_C_FLAGS ENABLE_DOUBLE ENABLE_SSE ENABLE_SSE2 ENABLE_AVX ENABLE_AVX2 )
    CMAKE_C_FLAGS ENABLE_DOUBLE ENABLE_SSE ENABLE_SSE2 ENABLE_AVX )
if(DEFINED _fftw_backup_${_var})
  set(${_var} "${_fftw_backup_${_var}}" CACHE BOOL "" FORCE)
  unset(_fftw_backup_${_var})
else()
  unset(${_var} CACHE)
endif()
endforeach()


