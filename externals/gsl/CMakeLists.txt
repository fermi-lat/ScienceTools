# =========================================================================== #
# Gnu Scientific Library (GSL) 
# =========================================================================== #

cmake_minimum_required(VERSION 3.14)
cmake_policy(SET CMP0120 NEW)
set(CMAKE_POLICY_VERSION_MINIMUM 3.10)

include(FetchContent)
include(CheckIncludeFile)
include(CheckIncludeFiles)
include(CheckIncludeFileCXX)
include(CheckFunctionExists)
include(CheckCSourceCompiles)
include(CheckTypeSize)
include(CheckSymbolExists)
include(CheckLibraryExists)
include(CheckCCompilerFlag)
include(CheckCSourceRuns)
include(TestBigEndian)

message(STATUS "Local External Dependency GSL")
set(GSL_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/gsl")
set(GSL_VERSION "2.8")
set(GSL_MAJOR_VERSION 2)
set(GSL_MINOR_VERSION 8)

# Library checks                                                                                                                                                                             
check_library_exists(m pow "math.h" HAVE_LIBM)
if(HAVE_LIBM)
  set(CMAKE_REQUIRED_LIBRARIES m)
endif()


# Header checks
check_include_file(complex.h   HAVE_COMPLEX_H)
check_include_file(dlfcn.h     HAVE_DLFCN_H)
check_include_file(ieeefp.h    HAVE_IEEEFP_H)
check_include_file(inttypes.h  HAVE_INTTYPES_H)
check_include_file(stdlib.h    HAVE_STDLIB_H)
check_include_file(stdint.h    HAVE_STDINT_H)
check_include_file(stdio.h     HAVE_STDIO_H STDC_HEADERS)
check_include_file(string.h    HAVE_STRING_H)
check_include_file(strings.h   HAVE_STRINGS_H)
check_include_file(sys/stat.h  HAVE_SYS_STAT_H)
check_include_file(sys/types.h HAVE_SYS_TYPES_H)
check_include_file(unistd.h    HAVE_UNISTD_H)

# Function existence
check_function_exists(strdup   HAVE_STRDUP)
check_function_exists(strtol   HAVE_STRTOL)
check_function_exists(strtoul  HAVE_STRTOUL)
check_function_exists(memcpy   HAVE_MEMCPY)
check_function_exists(memmove  HAVE_MEMMOVE)
check_function_exists(vprintf HAVE_VPRINTF)
if(NOT HAVE_VPRINTF)
  check_function_exists(_doprnt HAVE_DOPRNT)
endif()

# Function declarations
check_symbol_exists("acosh" "math.h" HAVE_DECL_ACOSH)
check_symbol_exists("asinh" "math.h" HAVE_DECL_ASINH)
check_symbol_exists("atanh" "math.h" HAVE_DECL_ATANH)
check_symbol_exists("expm1" "math.h" HAVE_DECL_EXPM1)
check_symbol_exists("feenableexcept" "fenv.h" HAVE_DECL_FEENABLEEXCEPT)
check_symbol_exists("fesettrapenable" "fenv.h" HAVE_DECL_FESETTRAPENABLE)
if (HAVE_IEEEFP_H)
  set(IEEEFP_H ieeefp.h)
endif ()
check_symbol_exists("finite" math.h;${IEEEFP_H} HAVE_DECL_FINITE)
check_symbol_exists("frexp_t" "math.h" HAVE_DECL_FREXP_T)
check_symbol_exists("frexp" "math.h" HAVE_DECL_FREXP)
check_symbol_exists("hypot" "math.h" HAVE_DECL_HYPOT)
check_symbol_exists("isfinite" "math.h" HAVE_DECL_ISFINITE)
check_symbol_exists("isinf" "math.h" HAVE_DECL_ISINF)
check_symbol_exists("isnan" "math.h" HAVE_DECL_ISNAN)
check_symbol_exists("ldexp" "math.h" HAVE_DECL_LDEXP)
check_symbol_exists("log1p" "math.h" HAVE_DECL_LOG1P)

# Type existence
check_type_size("size_t" SIZEOF_SIZE_T)

# Check for x86 SSE support
check_cxx_compiler_flag("-msse" HAVE_FPU_X86_SSE)

check_type_size(size_t SIZEOF_SIZE_T)
check_type_size("long double" SIZEOF_LONG_DOUBLE)
#if (SIZEOF_LONG_DOUBLE)
#  set(USES_LONGDOUBLE 1)
#elseif (!SIZEOF_LONG_DOUBLE)
#  set(USES_LONGDOUBLE 0)
#endif()
  
# Check for inline keyword support
check_c_source_compiles("inline int foo() { return 1; } int main() { return foo(); }" HAVE_INLINE)
check_c_source_compiles("static inline int foo() { return 1; } int main() { return foo(); }" HAVE_C99_INLINE)
# Check if EXIT_SUCCESS and EXIT_FAILURE are defined in stdlib.h
check_c_source_compiles("#include <stdlib.h> int main() { int x = EXIT_SUCCESS; int y = EXIT_FAILURE; return x == 0 && y == 1; }" HAVE_EXIT_SUCCESS_AND_FAILURE)


# Compiles the source code, runs the program and sets ${VAR} to 1 if the
# return value is equal to ${RESULT}.
macro(check_run_result SRC RESULT VAR)
  set(SRC_FILE ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/src.c)
  file(WRITE ${SRC_FILE} "${SRC}")
  try_run(RUN_RESULT COMPILE_RESULT ${CMAKE_BINARY_DIR} ${SRC_FILE}
          CMAKE_FLAGS -DLINK_LIBRARIES:STRING=${CMAKE_REQUIRED_LIBRARIES})
  if (RUN_RESULT EQUAL ${RESULT})
    set(${VAR} 1)
  endif ()
endmacro()

# Check for extended precision registers (heuristic for x86 FP stack)
check_c_source_runs("volatile long double x = 1.0; volatile double y = x; return (x != y);" HAVE_EXTENDED_PRECISION_REGISTERS)

# Check IEEE comparisons, whether "x != x" is true for NaNs.
check_run_result("
  #include <math.h>
  int main (void)
  {
     int status; double inf, nan;
     inf = exp(1.0e10);
     nan = inf / inf ;
     status = (nan == nan);
     exit (status);
  }" 0 HAVE_IEEE_COMPARISONS)

# Check for IEEE denormalized arithmetic.
check_run_result("
  #include <math.h>
  int main (void)
  {
     int i, status;
     volatile double z = 1e-308;
     for (i = 0; i < 5; i++) { z = z / 10.0 ; };
     for (i = 0; i < 5; i++) { z = z * 10.0 ; };
     status = (z == 0.0);
     exit (status);
  }" 0 HAVE_IEEE_DENORMALS)

# Check for long double stdio.
check_run_result("
  #include <stdlib.h>
  #include <stdio.h>
  int main (void)
  {
    const char * s = \"5678.25\"; long double x = 1.234 ;
    fprintf(stderr,\"%Lg\n\",x) ;
    sscanf(s, \"%Lg\", &x);
    if (x == 5678.25) {exit (0);} else {exit(1); }
  }" 0 HAVE_PRINTF_LONGDOUBLE)

# Detect platform-specific IEEE floating-point interfaces.
# These macros are used to enable system-dependent workarounds for
# differences in IEEE behavior (e.g., NaN comparisons, denormals).
# Values are inferred using CMake system identifiers or `uname` output.
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
        set(HAVE_DARWIN86_IEEE_INTERFACE 1)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "powerpc" OR CMAKE_SYSTEM_PROCESSOR MATCHES "ppc")
        set(HAVE_DARWIN_IEEE_INTERFACE 1)
    endif()
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    execute_process(COMMAND uname -m OUTPUT_VARIABLE ARCH OUTPUT_STRIP_TRAILING_WHITESPACE)
    if(ARCH MATCHES "sparc")
        set(HAVE_GNUSPARC_IEEE_INTERFACE 1)
    elseif(ARCH MATCHES "m68k")
        set(HAVE_GNUM68K_IEEE_INTERFACE 1)
    elseif(ARCH MATCHES "ppc")
        set(HAVE_GNUPPC_IEEE_INTERFACE 1)
    elseif(ARCH MATCHES "i.86" OR ARCH MATCHES "x86_64")
        set(HAVE_GNUX86_IEEE_INTERFACE 1)
    endif()
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    set(HAVE_FREEBSD_IEEE_INTERFACE 1)
elseif(CMAKE_SYSTEM_NAME STREQUAL "NetBSD")
    set(HAVE_NETBSD_IEEE_INTERFACE 1)
elseif(CMAKE_SYSTEM_NAME STREQUAL "OpenBSD")
    set(HAVE_OPENBSD_IEEE_INTERFACE 1)
endif()

unset(CMAKE_REQUIRED_LIBRARIES)

# # Configure gsl_version.h
# configure_file(
#   ${CMAKE_CURRENT_SOURCE_DIR}/cmake/gsl_version.h.in
#   ${CMAKE_CURRENT_BINARY_DIR}/gsl/gsl/gsl_version.h
#   @ONLY
# )
configure_file (${CMAKE_CURRENT_SOURCE_DIR}/cmake/gsl-config.h.in
                ${CMAKE_CURRENT_BINARY_DIR}/gsl/config.h)

file(GLOB_RECURSE HEADERS1 RELATIVE ${GSL_SOURCE_DIR} "gsl_*.h")
file(GLOB HEADERS2 RELATIVE ${GSL_SOURCE_DIR} "*.h")
list(APPEND GSL_HEADERS ${HEADERS1})
list(APPEND GSL_HEADERS ${HEADERS2})
list(REMOVE_DUPLICATES GSL_HEADERS)

foreach(header IN LISTS GSL_HEADERS)
    get_filename_component(hname ${header} NAME)
    configure_file(${GSL_SOURCE_DIR}/${header}
                   ${CMAKE_CURRENT_BINARY_DIR}/gsl/gsl/${hname}
                   COPYONLY)
endforeach()

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/gsl-sources.cmake)
list(TRANSFORM GSL_SOURCES PREPEND "${GSL_SOURCE_DIR}/")

add_library(gsl OBJECT ${GSL_SOURCES})

target_compile_definitions(gsl PRIVATE HAVE_CONFIG_H)
target_include_directories(gsl 
    PRIVATE
    "$<BUILD_INTERFACE:${GSL_SOURCE_DIR}>"
    PUBLIC
    "$<INSTALL_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/gsl>"
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/gsl>"
    )
  
add_library(GSL::gsl ALIAS gsl)
