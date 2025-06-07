# ########################################################################### #
# Vendored Externals
# ########################################################################### #

cmake_minimum_required(VERSION 3.14)
cmake_policy(SET CMP0120 NEW)
set(CMAKE_POLICY_VERSION_MINIMUM 3.10)
include(FetchContent)

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

include(CheckIncludeFile)
include(CheckIncludeFileCXX)
include(CheckSymbolExists)

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
