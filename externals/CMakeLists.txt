# ########################################################################### #
# Vendored Externals
# ########################################################################### #

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


# =========================================================================== #
# cfitsio
# =========================================================================== #

message(STATUS "Local External Dependency CppUnit")
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

message(STATUS "Local External Dependency CppUnit")
set(CLHEP_SOURCE_DIR "${CMAKE_SOURCE_DIR}/externals/clhep")
set(CLHEP_INCLUDE_DIR  "externals/clhep/include")
set(CLHEP_BINARY_INC "${CMAKE_BINARY_DIR}/${CLHEP_INCLUDE_DIR}")
file(MAKE_DIRECTORY "${CLHEP_BINARY_INC}/CLHEP")
set(CLHEP_VERSION 2.4.7.1)

# check for required functions
CHECK_FUNCTION_EXISTS(drand48 found_drand48)

# configures
foreach(COMPONENT IN ITEMS Units Utility Random Vector Geometry Matrix)
    set(COMPONENT_DIR "${CLHEP_SOURCE_DIR}/${COMPONENT}/${COMPONENT}")
    set(COMPONENT_DEST "${CLHEP_BINARY_INC}/CLHEP/${COMPONENT}")
    file(MAKE_DIRECTORY "${COMPONENT_DEST}")
    configure_file(${COMPONENT_DIR}/cmake-defs.h.in ${COMPONENT_DEST}/defs.h @ONLY)

    if(EXISTS "${COMPONENT_DIR}/thread_local.in")
        configure_file(${COMPONENT_DIR}/thread_local.in
                       ${COMPONENT_DEST}/thread_local.h
                       @ONLY)
    endif()

    file(GLOB COMPONENT_HEADERS "${COMPONENT_DIR}/*.h" "${COMPONENT_DIR}/*.icc")
    file(COPY ${COMPONENT_HEADERS} DESTINATION "${COMPONENT_DEST}")
endforeach()

# Units
add_library(CLHEP-Units INTERFACE) 
target_include_directories(CLHEP-Units INTERFACE 
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)

# Utility
add_library(CLHEP-Utility INTERFACE) 
target_include_directories(CLHEP-Utility INTERFACE
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)

# Random
add_library(CLHEP-Random STATIC) 

set(CLHEP_RANDOM_SRC DoubConv.cc DRand48Engine.cc DualRand.cc EngineFactory.cc
    engineIDulong.cc erfQ.cc flatToGaussian.cc gammln.cc Hurd160Engine.cc
    Hurd288Engine.cc JamesRandom.cc MixMaxRng.cc MTwistEngine.cc NonRandomEngine.cc
    RandBinomial.cc RandBit.cc RandBreitWigner.cc RandChiSquare.cc RandEngine.cc
    RandExponential.cc RandExpZiggurat.cc RandFlat.cc RandGamma.cc RandGauss.cc
    RandGaussQ.cc RandGaussT.cc RandGaussZiggurat.cc RandGeneral.cc RandLandau.cc
    Random.cc RandomEngine.cc RandPoisson.cc RandPoissonQ.cc RandPoissonT.cc
    RandSkewNormal.cc RandStudentT.cc RanecuEngine.cc Ranlux64Engine.cc RanluxEngine.cc
    RanluxppEngine.cc RanshiEngine.cc StaticRandomStates.cc TripleRand.cc)
list(TRANSFORM CLHEP_RANDOM_SRC PREPEND "${CLHEP_SOURCE_DIR}/Random/src/")
target_sources(CLHEP-Random PRIVATE ${CLHEP_RANDOM_SRC})

target_include_directories(CLHEP-Random PRIVATE
    "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
    "$<BUILD_INTERFACE:${CLHEP_SOURCE_DIR}/Random>"
)
target_link_libraries(CLHEP-Random
    PRIVATE CLHEP-Utility CLHEP-Units Threads::Threads
)
target_link_options(CLHEP-Random PRIVATE
  "$<$<PLATFORM_ID:Darwin>:-Wl,-undefined,error>"
  "$<$<NOT:$<PLATFORM_ID:Darwin>>:-Wl,--no-undefined>"
)
target_compile_definitions(CLHEP-Random PUBLIC CLHEP_THREAD_LOCAL=thread_local)
add_library(CLHEP::Random ALIAS  CLHEP-Random)
add_library(CLHEP::RandomS ALIAS CLHEP-Random)

# Vector
add_library(CLHEP-Vector STATIC) 
set(CLHEP_VECTOR_SRC AxisAngle.cc Boost.cc BoostX.cc BoostY.cc BoostZ.cc EulerAngles.cc
    LorentzRotation.cc LorentzRotationC.cc LorentzRotationD.cc LorentzVector.cc
    LorentzVectorB.cc LorentzVectorC.cc LorentzVectorK.cc LorentzVectorL.cc
    LorentzVectorR.cc Rotation.cc RotationA.cc RotationC.cc RotationE.cc RotationIO.cc
    RotationInterfaces.cc RotationL.cc RotationP.cc RotationX.cc RotationY.cc
    RotationZ.cc SpaceVector.cc SpaceVectorD.cc SpaceVectorP.cc SpaceVectorR.cc
    ThreeVector.cc ThreeVectorR.cc TwoVector.cc ZMinput.cc ZMxpv.cc)

list(TRANSFORM CLHEP_VECTOR_SRC PREPEND "${CLHEP_SOURCE_DIR}/Vector/src/")
target_sources(CLHEP-Vector PRIVATE ${CLHEP_VECTOR_SRC})

target_include_directories(CLHEP-Vector INTERFACE 
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)
target_link_libraries(CLHEP-Vector PUBLIC CLHEP-Units)
add_library(CLHEP::Vector ALIAS CLHEP-Vector)
add_library(CLHEP::VectorS ALIAS CLHEP-Vector)

# Geometry
add_library(CLHEP-Geometry STATIC) 
set(CLHEP_GEOMETRY_SRC "${CLHEP_SOURCE_DIR}/Geometry/src")
target_sources(CLHEP-Geometry PRIVATE
    ${CLHEP_GEOMETRY_SRC}/BasicVector3D.cc ${CLHEP_GEOMETRY_SRC}/Normal3D.cc     
    ${CLHEP_GEOMETRY_SRC}/Plane3D.cc      ${CLHEP_GEOMETRY_SRC}/Point3D.cc      
    ${CLHEP_GEOMETRY_SRC}/Transform3D.cc  ${CLHEP_GEOMETRY_SRC}/Vector3D.cc
)
target_include_directories(CLHEP-Geometry INTERFACE 
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)
target_link_libraries(CLHEP-Geometry PUBLIC CLHEP-Vector)
add_library(CLHEP::Geometry ALIAS CLHEP-Geometry)
add_library(CLHEP::GeometryS ALIAS CLHEP-Geometry)

# Matrix
add_library(CLHEP-Matrix STATIC)
set(CLHEP_MATRIX_SRC "${CLHEP_SOURCE_DIR}/Matrix/src")
target_sources(CLHEP-Matrix PRIVATE
    ${CLHEP_MATRIX_SRC}/DiagMatrix.cc   ${CLHEP_MATRIX_SRC}/GenMatrix.cc
    ${CLHEP_MATRIX_SRC}/Matrix.cc ${CLHEP_MATRIX_SRC}/MatrixEqRotation.cc
    ${CLHEP_MATRIX_SRC}/MatrixInvert.cc ${CLHEP_MATRIX_SRC}/MatrixLinear.cc
    ${CLHEP_MATRIX_SRC}/SymMatrix.cc ${CLHEP_MATRIX_SRC}/SymMatrixInvert.cc
    ${CLHEP_MATRIX_SRC}/Vector.cc
)
target_include_directories(CLHEP-Matrix INTERFACE 
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)
target_link_libraries(CLHEP-Matrix
    PUBLIC CLHEP::VectorS CLHEP::RandomS Threads::Threads
)
target_compile_definitions(CLHEP-Matrix PUBLIC 
    DISABLE_ALLOC
    CLHEP_THREAD_LOCAL=thread_local
)
add_library(CLHEP::Matrix ALIAS CLHEP-Matrix)
add_library(CLHEP::MatrixS ALIAS CLHEP-Matrix)


# ====================================================================== #
# CppUnit – LibreOffice fork (autotools), static-only                    #
# ====================================================================== #

message(STATUS "Local External Dependency CppUnit")

set(CPPUNIT_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/cppunit)

set(_macros
  CPPUNIT_HAVE_UNISTD_H   "unistd.h"
  CPPUNIT_HAVE_SYS_TIME_H "sys/time.h"
  CPPUNIT_HAVE_STDINT_H   "stdint.h"
  CPPUNIT_HAVE_DLFCN_H    "dlfcn.h"
)

while(_cppunit_macro_headers)
  list(POP_FRONT _cppunit_macro_headers _sym)   # macro name
  list(POP_FRONT _cppunit_macro_headers _hdr)   # header file
  check_include_file("${_hdr}" ${_sym})
endwhile()

check_symbol_exists(dlopen   "dlfcn.h"  CPPUNIT_HAVE_DLOPEN)
check_include_file_cxx("sstream"        CPPUNIT_HAVE_SSTREAM)
check_include_file_cxx("strstream"      CPPUNIT_HAVE_STRSTREAM)
check_include_file_cxx("cmath"          CPPUNIT_HAVE_CMATH)

set(_cfg "${CMAKE_CURRENT_BINARY_DIR}/cppunit/config-auto.h")

file(WRITE ${_cfg} "/* Auto-generated by CMake.  Do not edit. */\n#pragma once\n\n")

# generate 0/1 definitions
foreach(sym
        CPPUNIT_HAVE_UNISTD_H
        CPPUNIT_HAVE_SYS_TIME_H
        CPPUNIT_HAVE_STDINT_H
        CPPUNIT_HAVE_DLFCN_H
        CPPUNIT_HAVE_DLOPEN
        CPPUNIT_HAVE_SSTREAM
        CPPUNIT_HAVE_STRSTREAM
        CPPUNIT_HAVE_CMATH)
  if(${sym})
    file(APPEND ${_cfg} "#define ${sym} 1\n")
  else()
    file(APPEND ${_cfg} "#define ${sym} 0\n")
  endif()
endforeach()

# Always true on modern toolchains
file(APPEND ${_cfg} "\n#define CPPUNIT_HAVE_STD 1\n")
file(APPEND ${_cfg} "#define CPPUNIT_HAVE_NAMESPACES 1\n")

file(GLOB_RECURSE CPPUNIT_SOURCES CONFIGURE_DEPENDS
     "${CPPUNIT_SRC_DIR}/src/cppunit/*.cpp")

if(NOT WIN32)
  list(FILTER CPPUNIT_SOURCES EXCLUDE REGEX ".*/DllMain\\.cpp$")
endif()

add_library(cppunit_static STATIC ${CPPUNIT_SOURCES})
set_target_properties(cppunit_static PROPERTIES
    POSITION_INDEPENDENT_CODE TRUE
    OUTPUT_NAME cppunit)

target_include_directories(cppunit_static
PUBLIC "${CMAKE_CURRENT_BINARY_DIR}"
    "${CPPUNIT_SRC_DIR}/include"
    "${CPPUNIT_SRC_DIR}/src"
)
add_library(CppUnit::CppUnit ALIAS cppunit_static)


# =========================================================================== #
# FFTW 3.3.10
# =========================================================================== #

message(STATUS "Local External Dependency FFTW3")

# Cache original values
foreach(_var IN ITEMS 
    CMAKE_POSITION_INDEPENDENT_CODE BUILD_SHARED_LIBS TESTS ENABLE_THREADS
    CMAKE_C_FLAGS ENABLE_DOUBLE ENABLE_SSE ENABLE_SSE2 ENABLE_AVX ENABLE_AVX2 )                                          
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
set(ENABLE_AVX2 ON CACHE BOOL "" FORCE)

FetchContent_Declare(fftw
  URL https://www.fftw.org/fftw-3.3.10.tar.gz
  URL_HASH SHA256=56c932549852cddcfafdab3820b0200c7742675be92179e59e6215b340e26467
  DOWNLOAD_EXTRACT_TIMESTAMP true
  PATCH_COMMAND patch -p1 < ${CMAKE_SOURCE_DIR}/externals/patches/fftw.patch
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
if(DEFINED _fftw_backup_${_var})
  set(${_var} "${_fftw_backup_${_var}}" CACHE BOOL "" FORCE)
  unset(_fftw_backup_${_var})
else()
  unset(${_var} CACHE)
endif()
endforeach()


# =========================================================================== #
# F2C 
# =========================================================================== #

message(STATUS "Local External Dependency F2C")


FetchContent_Declare(f2c_src
  URL https://web.archive.org/web/20210322095636/https://netlib.sandia.gov/f2c/libf2c.zip
  URL_HASH SHA256=ca404070e9ce0a9aaa6a71fc7d5489d014ade952c5d6de7efb88de8e24f2e8e0
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)

FetchContent_MakeAvailable(f2c_src)

file( WRITE ${f2c_src_SOURCE_DIR}/arith.h
  "#define IEEE_8087
#define Arith_Kind_ASL 1
#define Long int
#define Intcast (int)(long)
#define Double_Align
#define X64_bit_pointers
#define NANCHECK
#define QNaN0 0x0
#define QNaN1 0x7ff80000"
)

file(WRITE ${f2c_src_SOURCE_DIR}/MAIN_stub.c "int MAIN__(int argc, char *argv[]) { return 0; }")
file(COPY_FILE ${f2c_src_SOURCE_DIR}/signal1.h0 ${f2c_src_SOURCE_DIR}/signal1.h)
file(COPY_FILE ${f2c_src_SOURCE_DIR}/sysdep1.h0 ${f2c_src_SOURCE_DIR}/sysdep1.h)
file(COPY_FILE ${f2c_src_SOURCE_DIR}/f2c.h0 ${f2c_src_SOURCE_DIR}/f2c.h)
file(READ ${f2c_src_SOURCE_DIR}/f2ch.add F2CHADD)
file(APPEND ${f2c_src_SOURCE_DIR}/f2c.h "${F2CHADD}")
file(MAKE_DIRECTORY ${f2c_src_SOURCE_DIR}/f2c)
file(COPY_FILE ${f2c_src_SOURCE_DIR}/f2c.h ${f2c_src_SOURCE_DIR}/f2c/f2c.h)

#### Source object groups as defined in makefile.u
set(MISC f77vers.c i77vers.c main.c MAIN_stub.c s_rnge.c abort_.c exit_.c getarg_.c
    iargc_.c getenv_.c signal_.c s_stop.c s_paus.c system_.c cabs.c ctype.c derf_.c
    derfc_.c erf_.c erfc_.c sig_die.c uninit.c)
set(POW pow_ci.c pow_dd.c pow_di.c pow_hh.c pow_ii.c pow_ri.c pow_zi.c pow_zz.c)
set(CX c_abs.c c_cos.c c_div.c c_exp.c c_log.c c_sin.c c_sqrt.c)
set(DCX z_abs.c z_cos.c z_div.c z_exp.c z_log.c z_sin.c z_sqrt.c)
set(REAL r_abs.c r_acos.c r_asin.c r_atan.c r_atn2.c r_cnjg.c r_cos.c r_cosh.c r_dim.c
    r_exp.c r_imag.c r_int.c r_lg10.c r_log.c r_mod.c r_nint.c r_sign.c r_sin.c
    r_sinh.c r_sqrt.c r_tan.c r_tanh.c)
set(DBL d_abs.c d_acos.c d_asin.c d_atan.c d_atn2.c d_cnjg.c d_cos.c d_cosh.c d_dim.c
    d_exp.c d_imag.c d_int.c d_lg10.c d_log.c d_mod.c d_nint.c d_prod.c d_sign.c
    d_sin.c d_sinh.c d_sqrt.c d_tan.c d_tanh.c)
set(INT i_abs.c i_dim.c i_dnnt.c i_indx.c i_len.c i_mod.c i_nint.c i_sign.c lbitbits.c
    lbitshft.c)
set(HALF h_abs.c h_dim.c h_dnnt.c h_indx.c h_len.c h_mod.c h_nint.c h_sign.c)
set(CMP l_ge.c l_gt.c l_le.c l_lt.c hl_ge.c hl_gt.c hl_le.c hl_lt.c)
set(EFL ef1asc_.c ef1cmc_.c)
set(CHAR f77_aloc.c s_cat.c s_cmp.c s_copy.c)
set(I77 backspac.c close.c dfe.c dolio.c due.c endfile.c err.c fmt.c fmtlib.c ftell_.c
    iio.c ilnw.c inquire.c lread.c lwrite.c open.c rdfmt.c rewind.c rsfe.c rsli.c
    rsne.c sfe.c sue.c typesize.c uio.c util.c wref.c wrtfmt.c wsfe.c wsle.c wsne.c
    xwsne.c)
set(QINT pow_qq.c qbitbits.c qbitshft.c ftell64_.c)
set(TIME dtime_.c etime_.c)
set(OFILES ${MISC} ${POW} ${CX} ${DCX} ${REAL} ${DBL} ${INT} ${HALF} ${CMP} ${EFL}
  ${CHAR} ${I77} ${QINT} ${TIME})
list(TRANSFORM OFILES PREPEND "${f2c_src_SOURCE_DIR}/")

#### Shared and static library generation
add_library(f2cobjs OBJECT ${OFILES})
target_compile_definitions(f2cobjs PUBLIC Skip_f2c_Undefs INTEGER_STAR_8)

add_library(f2c_static STATIC $<TARGET_OBJECTS:f2cobjs>)
set_target_properties(f2c_static PROPERTIES OUTPUT_NAME f2c POSITION_INDEPENDENT_CODE 1)
target_include_directories (f2c_static INTERFACE
  $<BUILD_INTERFACE:${f2c_src_SOURCE_DIR}>
  $<INSTALL_INTERFACE:>)

target_compile_definitions(f2c_static INTERFACE Skip_f2c_Undefs INTEGER_STAR_8)
add_library(f2c::f2c ALIAS f2c_static)


# =========================================================================== #
# Gnu Scientific Library (GSL) 
# =========================================================================== #

set(GSL_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/gsl")
set(GSL_VERSION "2.8")
set(GSL_MAJOR_VERSION 2)
set(GSL_MINOR_VERSION 8)

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
check_symbol_exists("finite" "math.h" HAVE_DECL_FINITE)
check_symbol_exists("frexp_t" "math.h" HAVE_DECL_FREXP_T)
check_symbol_exists("frexp" "math.h" HAVE_DECL_FREXP)
check_symbol_exists("hypot" "math.h" HAVE_DECL_HYPOT)
check_symbol_exists("isfinite" "math.h" HAVE_DECL_ISFINITE)
check_symbol_exists("isinf" "math.h" HAVE_DECL_ISINF)
check_symbol_exists("isnan" "math.h" HAVE_DECL_ISNAN)
check_symbol_exists("ldexp" "math.h" HAVE_DECL_LDEXP)
check_symbol_exists("log1p" "math.h" HAVE_DECL_LOG1P)

# Library checks
check_library_exists(m pow "math.h" HAVE_LIBM)

# Type existence
check_type_size("size_t" SIZEOF_SIZE_T)

# Check for x86 SSE support
check_cxx_compiler_flag("-msse" HAVE_FPU_X86_SSE)

check_type_size(size_t SIZEOF_SIZE_T)
check_type_size("long double" SIZEOF_LONG_DOUBLE)

# Check for inline keyword support
check_c_source_compiles("inline int foo() { return 1; } int main() { return foo(); }" HAVE_INLINE)
check_c_source_compiles("static inline int foo() { return 1; } int main() { return foo(); }" HAVE_C99_INLINE)
# Check if EXIT_SUCCESS and EXIT_FAILURE are defined in stdlib.h
check_c_source_compiles("#include <stdlib.h> int main() { int x = EXIT_SUCCESS; int y = EXIT_FAILURE; return x == 0 && y == 1; }" HAVE_EXIT_SUCCESS_AND_FAILURE)
# Check for extended precision registers (heuristic for x86 FP stack)
check_c_source_runs("volatile long double x = 1.0; volatile double y = x; return (x != y);" HAVE_EXTENDED_PRECISION_REGISTERS)
# IEEE comparisons (NaN != NaN)
check_c_source_runs(" #include <math.h> int main() { volatile double x = 0.0 / 0.0; return x != x ? 0 : 1; }" HAVE_IEEE_COMPARISONS)
# IEEE denormals (detect if denormals are preserved)
check_c_source_runs(" #include <math.h> #include <float.h> int main() { volatile double d = DBL_MIN / 2.0; return d != 0.0 ? 0 : 1; }" HAVE_IEEE_DENORMALS)
check_c_source_runs(" #include <stdio.h> int main() { long double x = 1.234L; return printf(\"%Lf\\n\", x) < 0; }" HAVE_PRINTF_LONGDOUBLE)
check_c_source_compiles(" volatile int x; int main() { return x; } " HAVE_VOLATILE)

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

# Configure gsl_version.h
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/gsl_version.h.in
  ${CMAKE_CURRENT_BINARY_DIR}/gsl/gsl_version.h
  @ONLY
)
configure_file (${CMAKE_CURRENT_SOURCE_DIR}/cmake/gsl-config.h.in
                ${CMAKE_CURRENT_BINARY_DIR}/gsl/config.h)

# Ordered list of GSL subdirectories
set(GSL_SOURES
 utils/placeholder.c
 sys/minmax.c sys/prec.c sys/hypot.c sys/log1p.c sys/expm1.c sys/coerce.c sys/invhyp.c sys/pow_int.c sys/infnan.c sys/fdiv.c sys/fcmp.c sys/ldfrexp.c
 err/error.c err/stream.c err/message.c err/strerror.c
 bst/avl.c bst/bst.c bst/rb.c bst/trav.c
 complex/math.c complex/inline.c
 cheb/deriv.c cheb/eval.c cheb/init.c cheb/integ.c
 block/init.c block/file.c block/block.c
 vector/init.c vector/file.c vector/vector.c vector/copy.c vector/swap.c vector/prop.c vector/minmax.c vector/oper.c vector/reim.c vector/subvector.c vector/view.c
 matrix/init.c matrix/matrix.c matrix/file.c matrix/rowcol.c matrix/swap.c matrix/copy.c matrix/minmax.c matrix/prop.c matrix/oper.c matrix/getset.c matrix/view.c matrix/submatrix.c
 permutation/init.c permutation/file.c permutation/permutation.c permutation/permute.c permutation/canonical.c permutation/inline.c
 combination/init.c combination/file.c combination/combination.c combination/inline.c
 multiset/init.c multiset/file.c multiset/multiset.c multiset/inline.c
 sort/sort.c sort/sortind.c sort/sortvec.c sort/sortvecind.c sort/subset.c sort/subsetind.c
 ieee-utils/print.c ieee-utils/make_rep.c ieee-utils/env.c ieee-utils/fp.c ieee-utils/read.c
 cblas/sasum.c cblas/saxpy.c cblas/scasum.c cblas/scnrm2.c cblas/scopy.c cblas/sdot.c cblas/sdsdot.c cblas/sgbmv.c cblas/sgemm.c cblas/sgemv.c cblas/sger.c cblas/snrm2.c cblas/srot.c cblas/srotg.c cblas/srotm.c cblas/srotmg.c cblas/ssbmv.c cblas/sscal.c cblas/sspmv.c cblas/sspr.c cblas/sspr2.c cblas/sswap.c cblas/ssymm.c cblas/ssymv.c cblas/ssyr.c cblas/ssyr2.c cblas/ssyr2k.c cblas/ssyrk.c cblas/stbmv.c cblas/stbsv.c cblas/stpmv.c cblas/stpsv.c cblas/strmm.c cblas/strmv.c cblas/strsm.c cblas/strsv.c cblas/dasum.c cblas/daxpy.c cblas/dcopy.c cblas/ddot.c cblas/dgbmv.c cblas/dgemm.c cblas/dgemv.c cblas/dger.c cblas/dnrm2.c cblas/drot.c cblas/drotg.c cblas/drotm.c cblas/drotmg.c cblas/dsbmv.c cblas/dscal.c cblas/dsdot.c cblas/dspmv.c cblas/dspr.c cblas/dspr2.c cblas/dswap.c cblas/dsymm.c cblas/dsymv.c cblas/dsyr.c cblas/dsyr2.c cblas/dsyr2k.c cblas/dsyrk.c cblas/dtbmv.c cblas/dtbsv.c cblas/dtpmv.c cblas/dtpsv.c cblas/dtrmm.c cblas/dtrmv.c cblas/dtrsm.c cblas/dtrsv.c cblas/dzasum.c cblas/dznrm2.c cblas/caxpy.c cblas/ccopy.c cblas/cdotc_sub.c cblas/cdotu_sub.c cblas/cgbmv.c cblas/cgemm.c cblas/cgemv.c cblas/cgerc.c cblas/cgeru.c cblas/chbmv.c cblas/chemm.c cblas/chemv.c cblas/cher.c cblas/cher2.c cblas/cher2k.c cblas/cherk.c cblas/chpmv.c cblas/chpr.c cblas/chpr2.c cblas/cscal.c cblas/csscal.c cblas/cswap.c cblas/csymm.c cblas/csyr2k.c cblas/csyrk.c cblas/ctbmv.c cblas/ctbsv.c cblas/ctpmv.c cblas/ctpsv.c cblas/ctrmm.c cblas/ctrmv.c cblas/ctrsm.c cblas/ctrsv.c cblas/zaxpy.c cblas/zcopy.c cblas/zdotc_sub.c cblas/zdotu_sub.c cblas/zdscal.c cblas/zgbmv.c cblas/zgemm.c cblas/zgemv.c cblas/zgerc.c cblas/zgeru.c cblas/zhbmv.c cblas/zhemm.c cblas/zhemv.c cblas/zher.c cblas/zher2.c cblas/zher2k.c cblas/zherk.c cblas/zhpmv.c cblas/zhpr.c cblas/zhpr2.c cblas/zscal.c cblas/zswap.c cblas/zsymm.c cblas/zsyr2k.c cblas/zsyrk.c cblas/ztbmv.c cblas/ztbsv.c cblas/ztpmv.c cblas/ztpsv.c cblas/ztrmm.c cblas/ztrmv.c cblas/ztrsm.c cblas/ztrsv.c cblas/icamax.c cblas/idamax.c cblas/isamax.c cblas/izamax.c cblas/xerbla.c
 blas/blas.c
 linalg/cod.c linalg/condest.c linalg/invtri.c linalg/invtri_complex.c linalg/multiply.c linalg/exponential.c linalg/tridiag.c linalg/lu.c linalg/lu_band.c linalg/luc.c linalg/hh.c linalg/ql.c linalg/qr.c linalg/qr_band.c linalg/qrc.c linalg/qrpt.c linalg/qr_ud.c linalg/qr_ur.c linalg/qr_uu.c linalg/qr_uz.c linalg/rqr.c linalg/rqrc.c linalg/lq.c linalg/ptlq.c linalg/svd.c linalg/householder.c linalg/householdercomplex.c linalg/hessenberg.c linalg/hesstri.c linalg/cholesky.c linalg/choleskyc.c linalg/mcholesky.c linalg/pcholesky.c linalg/cholesky_band.c linalg/ldlt.c linalg/ldlt_band.c linalg/symmtd.c linalg/hermtd.c linalg/bidiag.c linalg/balance.c linalg/balancemat.c linalg/inline.c linalg/trimult.c linalg/trimult_complex.c
 eigen/jacobi.c eigen/symm.c eigen/symmv.c eigen/nonsymm.c eigen/nonsymmv.c eigen/herm.c eigen/hermv.c eigen/gensymm.c eigen/gensymmv.c eigen/genherm.c eigen/genhermv.c eigen/gen.c eigen/genv.c eigen/sort.c eigen/francis.c eigen/schur.c
 specfunc/airy.c specfunc/airy_der.c specfunc/airy_zero.c specfunc/alf_P.c specfunc/atanint.c specfunc/bessel.c specfunc/bessel_I0.c specfunc/bessel_I1.c specfunc/bessel_In.c specfunc/bessel_Inu.c specfunc/bessel_J0.c specfunc/bessel_J1.c specfunc/bessel_Jn.c specfunc/bessel_Jnu.c specfunc/bessel_K0.c specfunc/bessel_K1.c specfunc/bessel_Kn.c specfunc/bessel_Knu.c specfunc/bessel_Y0.c specfunc/bessel_Y1.c specfunc/bessel_Yn.c specfunc/bessel_Ynu.c specfunc/bessel_amp_phase.c specfunc/bessel_i.c specfunc/bessel_j.c specfunc/bessel_k.c specfunc/bessel_olver.c specfunc/bessel_temme.c specfunc/bessel_y.c specfunc/bessel_zero.c specfunc/bessel_sequence.c specfunc/beta.c specfunc/beta_inc.c specfunc/clausen.c specfunc/coulomb.c specfunc/coupling.c specfunc/coulomb_bound.c specfunc/dawson.c specfunc/debye.c specfunc/dilog.c specfunc/elementary.c specfunc/ellint.c specfunc/elljac.c specfunc/erfc.c specfunc/exp.c specfunc/expint.c specfunc/expint3.c specfunc/fermi_dirac.c specfunc/gegenbauer.c specfunc/gamma.c specfunc/gamma_inc.c specfunc/hermite.c specfunc/hyperg_0F1.c specfunc/hyperg_2F0.c specfunc/hyperg_1F1.c specfunc/hyperg_2F1.c specfunc/hyperg_U.c specfunc/hyperg.c specfunc/inline.c specfunc/laguerre.c specfunc/lambert.c specfunc/legendre_H3d.c specfunc/legendre_P.c specfunc/legendre_Qn.c specfunc/legendre_con.c specfunc/legendre_poly.c specfunc/log.c specfunc/mathieu_angfunc.c specfunc/mathieu_charv.c specfunc/mathieu_coeff.c specfunc/mathieu_radfunc.c specfunc/mathieu_workspace.c specfunc/poch.c specfunc/pow_int.c specfunc/psi.c specfunc/result.c specfunc/shint.c specfunc/sincos_pi.c specfunc/sinint.c specfunc/synchrotron.c specfunc/transport.c specfunc/trig.c specfunc/zeta.c
 dht/dht.c
 qrng/qrng.c qrng/niederreiter-2.c qrng/sobol.c qrng/halton.c qrng/reversehalton.c qrng/inline.c
 rng/borosh13.c rng/cmrg.c rng/coveyou.c rng/default.c rng/file.c rng/fishman18.c rng/fishman20.c rng/fishman2x.c rng/gfsr4.c rng/knuthran2.c rng/knuthran.c rng/knuthran2002.c rng/lecuyer21.c rng/minstd.c rng/mrg.c rng/mt.c rng/r250.c rng/ran0.c rng/ran1.c rng/ran2.c rng/ran3.c rng/rand48.c rng/rand.c rng/random.c rng/randu.c rng/ranf.c rng/ranlux.c rng/ranlxd.c rng/ranlxs.c rng/ranmar.c rng/rng.c rng/slatec.c rng/taus.c rng/taus113.c rng/transputer.c rng/tt.c rng/types.c rng/uni32.c rng/uni.c rng/vax.c rng/waterman14.c rng/zuf.c rng/inline.c
 randist/bernoulli.c randist/beta.c randist/bigauss.c randist/binomial.c randist/cauchy.c randist/chisq.c randist/dirichlet.c randist/discrete.c randist/erlang.c randist/exponential.c randist/exppow.c randist/fdist.c randist/flat.c randist/gamma.c randist/gauss.c randist/gausszig.c randist/gausstail.c randist/geometric.c randist/gumbel.c randist/hyperg.c randist/laplace.c randist/levy.c randist/logarithmic.c randist/logistic.c randist/lognormal.c randist/multinomial.c randist/mvgauss.c randist/nbinomial.c randist/pareto.c randist/pascal.c randist/poisson.c randist/rayleigh.c randist/shuffle.c randist/sphere.c randist/tdist.c randist/weibull.c randist/landau.c randist/binomial_tpe.c randist/wishart.c
 fft/dft.c fft/fft.c
 poly/dd.c poly/eval.c poly/solve_quadratic.c poly/solve_cubic.c poly/zsolve_quadratic.c poly/zsolve_cubic.c poly/zsolve.c poly/zsolve_init.c poly/deriv.c
 fit/linear.c
 multifit/gcv.c multifit/multilinear.c multifit/multiwlinear.c multifit/work.c multifit/lmniel.c multifit/lmder.c multifit/fsolver.c multifit/fdfsolver.c multifit/fdfridge.c multifit/fdjac.c multifit/convergence.c multifit/gradient.c multifit/covar.c multifit/multirobust.c multifit/robust_wfun.c multifit/multireg.c
 multifit_nlinear/cholesky.c multifit_nlinear/convergence.c multifit_nlinear/covar.c multifit_nlinear/dogleg.c multifit_nlinear/fdf.c multifit_nlinear/fdfvv.c multifit_nlinear/fdjac.c multifit_nlinear/lm.c multifit_nlinear/mcholesky.c multifit_nlinear/qr.c multifit_nlinear/scaling.c multifit_nlinear/subspace2D.c multifit_nlinear/svd.c multifit_nlinear/trust.c
 multilarge/multilarge.c multilarge/normal.c multilarge/tsqr.c
 multilarge_nlinear/cgst.c multilarge_nlinear/cholesky.c multilarge_nlinear/convergence.c multilarge_nlinear/dogleg.c multilarge_nlinear/dummy.c multilarge_nlinear/fdf.c multilarge_nlinear/lm.c multilarge_nlinear/mcholesky.c multilarge_nlinear/scaling.c multilarge_nlinear/subspace2D.c multilarge_nlinear/trust.c
 filter/gaussian.c filter/impulse.c filter/median.c filter/rmedian.c
 movstat/alloc.c movstat/apply.c movstat/fill.c movstat/funcacc.c movstat/madacc.c movstat/medacc.c movstat/mmacc.c movstat/movmad.c movstat/movmean.c movstat/movmedian.c movstat/movminmax.c movstat/movsum.c movstat/movSn.c movstat/movQn.c movstat/movqqr.c movstat/movvariance.c movstat/mvacc.c movstat/qnacc.c movstat/qqracc.c movstat/snacc.c movstat/sumacc.c
 rstat/rstat.c rstat/rquantile.c
 statistics/mean.c statistics/variance.c statistics/absdev.c statistics/skew.c statistics/kurtosis.c statistics/lag1.c statistics/p_variance.c statistics/minmax.c statistics/ttest.c statistics/mad.c statistics/median.c statistics/covariance.c statistics/quantiles.c statistics/select.c statistics/Sn.c statistics/Qn.c statistics/gastwirth.c statistics/trmean.c statistics/wmean.c statistics/wvariance.c statistics/wabsdev.c statistics/wskew.c statistics/wkurtosis.c
 siman/siman.c
 sum/levin_u.c sum/levin_utrunc.c sum/work_u.c sum/work_utrunc.c
 integration/qk15.c integration/qk21.c integration/qk31.c integration/qk41.c integration/qk51.c integration/qk61.c integration/qk.c integration/qng.c integration/qag.c integration/qags.c integration/qagp.c integration/workspace.c integration/qcheb.c integration/qawc.c integration/qmomo.c integration/qaws.c integration/qmomof.c integration/qawo.c integration/qawf.c integration/glfixed.c integration/cquad.c integration/fixed.c integration/chebyshev.c integration/chebyshev2.c integration/legendre.c integration/hermite.c integration/laguerre.c integration/gegenbauer.c integration/jacobi.c integration/exponential.c integration/lebedev.c integration/rational.c integration/romberg.c
 interpolation/accel.c interpolation/akima.c interpolation/cspline.c interpolation/interp.c interpolation/linear.c interpolation/spline.c interpolation/poly.c interpolation/steffen.c interpolation/inline.c interpolation/interp2d.c interpolation/bilinear.c interpolation/bicubic.c interpolation/spline2d.c
 histogram/add.c histogram/get.c histogram/init.c histogram/params.c histogram/reset.c histogram/file.c histogram/pdf.c histogram/add2d.c histogram/get2d.c histogram/init2d.c histogram/params2d.c histogram/reset2d.c histogram/file2d.c histogram/pdf2d.c histogram/calloc_range.c histogram/calloc_range2d.c histogram/copy.c histogram/copy2d.c histogram/maxval.c histogram/maxval2d.c histogram/oper.c histogram/oper2d.c histogram/stat.c histogram/stat2d.c
 ode-initval/control.c ode-initval/cstd.c ode-initval/cscal.c ode-initval/evolve.c ode-initval/step.c ode-initval/rk2.c ode-initval/rk2imp.c ode-initval/rk2simp.c ode-initval/rk4.c ode-initval/rk4imp.c ode-initval/rkf45.c ode-initval/rk8pd.c ode-initval/rkck.c ode-initval/bsimp.c ode-initval/gear1.c ode-initval/gear2.c
 ode-initval2/control.c ode-initval2/cstd.c ode-initval2/cscal.c ode-initval2/evolve.c ode-initval2/step.c ode-initval2/rk2.c ode-initval2/rk2imp.c ode-initval2/rk4.c ode-initval2/rk4imp.c ode-initval2/rkf45.c ode-initval2/rk8pd.c ode-initval2/rkck.c ode-initval2/bsimp.c ode-initval2/rk1imp.c ode-initval2/msadams.c ode-initval2/msbdf.c ode-initval2/driver.c
 roots/bisection.c roots/brent.c roots/falsepos.c roots/newton.c roots/secant.c roots/steffenson.c roots/convergence.c roots/fsolver.c roots/fdfsolver.c
 multiroots/fdjac.c multiroots/fsolver.c multiroots/fdfsolver.c multiroots/convergence.c multiroots/newton.c multiroots/gnewton.c multiroots/dnewton.c multiroots/broyden.c multiroots/hybrid.c multiroots/hybridj.c
 min/fsolver.c min/golden.c min/brent.c min/convergence.c min/bracketing.c min/quad_golden.c
 multimin/fdfminimizer.c multimin/steepest_descent.c multimin/conjugate_fr.c multimin/conjugate_pr.c multimin/convergence.c multimin/diff.c multimin/vector_bfgs.c multimin/vector_bfgs2.c multimin/fminimizer.c multimin/simplex.c multimin/simplex2.c
 monte/miser.c monte/plain.c monte/vegas.c
 ntuple/ntuple.c
 diff/diff.c
 deriv/deriv.c
 cdf/beta.c cdf/betainv.c cdf/cauchy.c cdf/cauchyinv.c cdf/chisq.c cdf/chisqinv.c cdf/exponential.c cdf/exponentialinv.c cdf/exppow.c cdf/fdist.c cdf/fdistinv.c cdf/flat.c cdf/flatinv.c cdf/gamma.c cdf/gammainv.c cdf/gauss.c cdf/gaussinv.c cdf/gumbel1.c cdf/gumbel1inv.c cdf/gumbel2.c cdf/gumbel2inv.c cdf/laplace.c cdf/laplaceinv.c cdf/logistic.c cdf/logisticinv.c cdf/lognormal.c cdf/lognormalinv.c cdf/pareto.c cdf/paretoinv.c cdf/rayleigh.c cdf/rayleighinv.c cdf/tdist.c cdf/tdistinv.c cdf/weibull.c cdf/weibullinv.c cdf/binomial.c cdf/poisson.c cdf/geometric.c cdf/nbinomial.c cdf/pascal.c cdf/hypergeometric.c
 wavelet/dwt.c wavelet/wavelet.c wavelet/bspline.c wavelet/daubechies.c wavelet/haar.c
 bspline/bspline.c bspline/eval.c bspline/gram.c bspline/greville.c bspline/integ.c bspline/interp.c bspline/ls.c bspline/old.c bspline/inline.c
 spblas/spdgemm.c spblas/spdgemv.c
 spmatrix/compress.c spmatrix/copy.c spmatrix/file.c spmatrix/getset.c spmatrix/init.c spmatrix/minmax.c spmatrix/oper.c spmatrix/prop.c spmatrix/util.c spmatrix/swap.c
 splinalg/itersolve.c splinalg/gmres.c)
list(TRANSFORM GSL_SOURES PREPEND "${GSL_SOURCE_DIR}/")

add_library(gsl OBJECT ${GSL_SOURES})

target_compile_definitions(gsl PRIVATE HAVE_CONFIG_H=1)
target_include_directories(gsl PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/gsl
    ${GSL_SOURCE_DIR}
)

add_library(GSL::gsl ALIAS gsl)
