# =========================================================================== #
# FFTW 3.3.10
# =========================================================================== #

message(STATUS "Local External Dependency FFTW3")

include(FetchContent)

# Cache original values
foreach(_var IN ITEMS 
    CMAKE_POSITION_INDEPENDENT_CODE BUILD_SHARED_LIBS TESTS ENABLE_THREADS
    CMAKE_C_FLAGS ENABLE_DOUBLE ENABLE_SSE ENABLE_SSE2 ENABLE_AVX ENABLE_AVX2 )
    #CMAKE_C_FLAGS ENABLE_DOUBLE ENABLE_SSE ENABLE_SSE2 ENABLE_AVX )
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

FetchContent_Declare(fftw
  URL https://www.fftw.org/fftw-3.3.10.tar.gz
  URL_HASH SHA256=56c932549852cddcfafdab3820b0200c7742675be92179e59e6215b340e26467
  DOWNLOAD_EXTRACT_TIMESTAMP true
  PATCH_COMMAND patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/fftw.patch
)

FetchContent_MakeAvailable(fftw)

target_include_directories(fftw3 INTERFACE 
    "$<INSTALL_INTERFACE:include>"
    "$<BUILD_INTERFACE:${fftw_SOURCE_DIR}/api>")

add_library(FFTW::fftw3 ALIAS fftw3)

# Restore original values
foreach(_var IN ITEMS 
    CMAKE_POSITION_INDEPENDENT_CODE BUILD_SHARED_LIBS TESTS ENABLE_THREADS
    CMAKE_C_FLAGS ENABLE_DOUBLE ENABLE_SSE ENABLE_SSE2 ENABLE_AVX ENABLE_AVX2 )
    #CMAKE_C_FLAGS ENABLE_DOUBLE ENABLE_SSE ENABLE_SSE2 ENABLE_AVX )
if(DEFINED _fftw_backup_${_var})
  set(${_var} "${_fftw_backup_${_var}}" CACHE BOOL "" FORCE)
  unset(_fftw_backup_${_var})
else()
  unset(${_var} CACHE)
endif()
endforeach()


