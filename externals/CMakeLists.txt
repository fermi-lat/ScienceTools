# ########################################################################### #
# Vendored Externals
# ########################################################################### #

cmake_minimum_required(VERSION 3.14)
cmake_policy(SET CMP0120 NEW)
set(CMAKE_POLICY_VERSION_MINIMUM 3.10)
include(ExternalProject)

# =========================================================================== #
# cfitsio
# =========================================================================== #

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
set(CLHEP_RANDOM_SRC "${CLHEP_SOURCE_DIR}/Random/src")
target_sources(CLHEP-Random PRIVATE
    ${CLHEP_RANDOM_SRC}/DoubConv.cc
	${CLHEP_RANDOM_SRC}/DRand48Engine.cc
	${CLHEP_RANDOM_SRC}/DualRand.cc
	${CLHEP_RANDOM_SRC}/EngineFactory.cc
	${CLHEP_RANDOM_SRC}/engineIDulong.cc
	${CLHEP_RANDOM_SRC}/erfQ.cc
	${CLHEP_RANDOM_SRC}/flatToGaussian.cc
	${CLHEP_RANDOM_SRC}/gammln.cc
	${CLHEP_RANDOM_SRC}/Hurd160Engine.cc
	${CLHEP_RANDOM_SRC}/Hurd288Engine.cc
	${CLHEP_RANDOM_SRC}/JamesRandom.cc
	${CLHEP_RANDOM_SRC}/MixMaxRng.cc
	${CLHEP_RANDOM_SRC}/MTwistEngine.cc
	${CLHEP_RANDOM_SRC}/NonRandomEngine.cc
	${CLHEP_RANDOM_SRC}/RandBinomial.cc
	${CLHEP_RANDOM_SRC}/RandBit.cc
	${CLHEP_RANDOM_SRC}/RandBreitWigner.cc
	${CLHEP_RANDOM_SRC}/RandChiSquare.cc
	${CLHEP_RANDOM_SRC}/RandEngine.cc
	${CLHEP_RANDOM_SRC}/RandExponential.cc
	${CLHEP_RANDOM_SRC}/RandExpZiggurat.cc
	${CLHEP_RANDOM_SRC}/RandFlat.cc
	${CLHEP_RANDOM_SRC}/RandGamma.cc
	${CLHEP_RANDOM_SRC}/RandGauss.cc
	${CLHEP_RANDOM_SRC}/RandGaussQ.cc
	${CLHEP_RANDOM_SRC}/RandGaussT.cc
	${CLHEP_RANDOM_SRC}/RandGaussZiggurat.cc
	${CLHEP_RANDOM_SRC}/RandGeneral.cc
	${CLHEP_RANDOM_SRC}/RandLandau.cc
	${CLHEP_RANDOM_SRC}/Random.cc
	${CLHEP_RANDOM_SRC}/RandomEngine.cc
	${CLHEP_RANDOM_SRC}/RandPoisson.cc
	${CLHEP_RANDOM_SRC}/RandPoissonQ.cc
	${CLHEP_RANDOM_SRC}/RandPoissonT.cc
	${CLHEP_RANDOM_SRC}/RandSkewNormal.cc
	${CLHEP_RANDOM_SRC}/RandStudentT.cc
	${CLHEP_RANDOM_SRC}/RanecuEngine.cc
	${CLHEP_RANDOM_SRC}/Ranlux64Engine.cc
	${CLHEP_RANDOM_SRC}/RanluxEngine.cc
	${CLHEP_RANDOM_SRC}/RanluxppEngine.cc
	${CLHEP_RANDOM_SRC}/RanshiEngine.cc
	${CLHEP_RANDOM_SRC}/StaticRandomStates.cc
	${CLHEP_RANDOM_SRC}/TripleRand.cc
)
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
set(CLHEP_VECTOR_SRC "${CLHEP_SOURCE_DIR}/Vector/src")
target_sources(CLHEP-Vector
    PRIVATE
    ${CLHEP_VECTOR_SRC}/AxisAngle.cc
    ${CLHEP_VECTOR_SRC}/Boost.cc
	${CLHEP_VECTOR_SRC}/BoostX.cc
	${CLHEP_VECTOR_SRC}/BoostY.cc
	${CLHEP_VECTOR_SRC}/BoostZ.cc
	${CLHEP_VECTOR_SRC}/EulerAngles.cc
	${CLHEP_VECTOR_SRC}/LorentzRotation.cc
	${CLHEP_VECTOR_SRC}/LorentzRotationC.cc
	${CLHEP_VECTOR_SRC}/LorentzRotationD.cc
	${CLHEP_VECTOR_SRC}/LorentzVector.cc
	${CLHEP_VECTOR_SRC}/LorentzVectorB.cc
	${CLHEP_VECTOR_SRC}/LorentzVectorC.cc
	${CLHEP_VECTOR_SRC}/LorentzVectorK.cc
	${CLHEP_VECTOR_SRC}/LorentzVectorL.cc
	${CLHEP_VECTOR_SRC}/LorentzVectorR.cc
	${CLHEP_VECTOR_SRC}/Rotation.cc
	${CLHEP_VECTOR_SRC}/RotationA.cc
	${CLHEP_VECTOR_SRC}/RotationC.cc
	${CLHEP_VECTOR_SRC}/RotationE.cc
	${CLHEP_VECTOR_SRC}/RotationIO.cc
	${CLHEP_VECTOR_SRC}/RotationInterfaces.cc
	${CLHEP_VECTOR_SRC}/RotationL.cc
	${CLHEP_VECTOR_SRC}/RotationP.cc
	${CLHEP_VECTOR_SRC}/RotationX.cc
	${CLHEP_VECTOR_SRC}/RotationY.cc
	${CLHEP_VECTOR_SRC}/RotationZ.cc
	${CLHEP_VECTOR_SRC}/SpaceVector.cc
	${CLHEP_VECTOR_SRC}/SpaceVectorD.cc
	${CLHEP_VECTOR_SRC}/SpaceVectorP.cc
	${CLHEP_VECTOR_SRC}/SpaceVectorR.cc
	${CLHEP_VECTOR_SRC}/ThreeVector.cc
	${CLHEP_VECTOR_SRC}/ThreeVectorR.cc
	${CLHEP_VECTOR_SRC}/TwoVector.cc
	${CLHEP_VECTOR_SRC}/ZMinput.cc
	${CLHEP_VECTOR_SRC}/ZMxpv.cc )
target_include_directories(CLHEP-Vector INTERFACE 
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)
target_link_libraries(CLHEP-Vector PUBLIC CLHEP-Units)
add_library(CLHEP::Vector ALIAS CLHEP-Vector)
add_library(CLHEP::VectorS ALIAS CLHEP-Vector)

# Geometry
add_library(CLHEP-Geometry STATIC) 
set(CLHEP_GEOMETRY_SRC "${CLHEP_SOURCE_DIR}/Geometry/src")
target_sources(CLHEP-Geometry
    PRIVATE
    ${CLHEP_GEOMETRY_SRC}/BasicVector3D.cc
    ${CLHEP_GEOMETRY_SRC}/Normal3D.cc     
    ${CLHEP_GEOMETRY_SRC}/Plane3D.cc      
    ${CLHEP_GEOMETRY_SRC}/Point3D.cc      
    ${CLHEP_GEOMETRY_SRC}/Transform3D.cc  
    ${CLHEP_GEOMETRY_SRC}/Vector3D.cc)
target_include_directories(CLHEP-Geometry INTERFACE 
  "$<BUILD_INTERFACE:${CLHEP_BINARY_INC}>"
)
target_link_libraries(CLHEP-Geometry PUBLIC CLHEP-Vector)
add_library(CLHEP::Geometry ALIAS CLHEP-Geometry)
add_library(CLHEP::GeometryS ALIAS CLHEP-Geometry)

# Matrix
add_library(CLHEP-Matrix STATIC)
set(CLHEP_MATRIX_SRC "${CLHEP_SOURCE_DIR}/Matrix/src")
target_sources(CLHEP-Matrix
    PRIVATE
    ${CLHEP_MATRIX_SRC}/DiagMatrix.cc   
    ${CLHEP_MATRIX_SRC}/GenMatrix.cc
    ${CLHEP_MATRIX_SRC}/Matrix.cc
    ${CLHEP_MATRIX_SRC}/MatrixEqRotation.cc
    ${CLHEP_MATRIX_SRC}/MatrixInvert.cc
    ${CLHEP_MATRIX_SRC}/MatrixLinear.cc
    ${CLHEP_MATRIX_SRC}/SymMatrix.cc
    ${CLHEP_MATRIX_SRC}/SymMatrixInvert.cc
    ${CLHEP_MATRIX_SRC}/Vector.cc)
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

# provide tools for other packages to include CLHEP easily
# function(clhep_project_toolchain)
#     clhep_toolchain()
# endfunction()
# clhep_project_toolchain()
# set(CLHEP_libraries_all ${CLHEP_libraries})
# foreach(_lib ${CLHEP_libraries})
#   list(APPEND CLHEP_libraries_all "${_lib}S")
# endforeach()
#
# # export(TARGETS CLHEP CLHEPS ${CLHEP_libraries_all}
# #   NAMESPACE "CLHEP::"
# #   FILE ${CLHEP_BINARY_DIR}/CLHEPLibraryDepends.cmake
# #   )
# #
# # # Now we configure the CLHEPConfig and CLHEPConfigVersion file templates,
# # # outputting to a directory in the build directory. This is simply a
# # # placeholder to store them until we install later.  
# # configure_file(${CLHEP_SOURCE_DIR}/cmake/Templates/CLHEPConfigVersion.cmake.in
# #   ${CLHEP_BINARY_DIR}/InstallTreeFiles/CLHEPConfigVersion.cmake 
# #   @ONLY
# #   )
# #
# # set(CLHEP_INCLUDE_DIR include)
# # configure_package_config_file(${CLHEP_SOURCE_DIR}/cmake/Templates/CLHEPConfig.cmake.in
# #   ${CLHEP_BINARY_DIR}/InstallTreeFiles/CLHEPConfig.cmake
# #   INSTALL_DESTINATION lib${LIB_SUFFIX}/CLHEP-${CLHEP_VERSION}
# #   PATH_VARS CLHEP_INCLUDE_DIR
# #   )
# #
# # install(FILES
# #   ${CLHEP_BINARY_DIR}/InstallTreeFiles/CLHEPConfigVersion.cmake 
# #   ${CLHEP_BINARY_DIR}/InstallTreeFiles/CLHEPConfig.cmake 
# #   DESTINATION lib${LIB_SUFFIX}/CLHEP-${CLHEP_VERSION}
# #   )
# #
# # install(EXPORT CLHEPLibraryDepends 
# #         NAMESPACE "CLHEP::"
# #         DESTINATION lib${LIB_SUFFIX}/CLHEP-${CLHEP_VERSION})

# set_target_properties(
#   CLHEP::Units
#   CLHEP::Utility
#   CLHEP::Vector
#   CLHEP::VectorS
#   CLHEP::Random
#   CLHEP::RandomS
#   CLHEP::Geometry
#   CLHEP::GeometryS
#   CLHEP::Matrix
#   CLHEP::MatrixS
#   PROPERTIES IMPORTED_GLOBAL TRUE
# )


# Custom Packaging
# include(ClhepPackaging)

# set(_clhep_src       ${CMAKE_SOURCE_DIR}/externals/clhep)
# set(_clhep_install   ${CMAKE_BINARY_DIR}/externals/clhep/install)
#
# file(STRINGS "${_clhep_src}/CMakeLists.txt" _clhep_ver_line
#      REGEX "^project\\(CLHEP VERSION [0-9.]+")
# string(REGEX REPLACE ".*VERSION ([0-9.]+).*" "\\1" _clhep_ver "${_clhep_ver_line}")
# message(STATUS "CLHEP version detected: ${_clhep_ver}")
#
# ExternalProject_Add(clhep_external
#   SOURCE_DIR          ${_clhep_src}
#   UPDATE_COMMAND      "" # never auto-update the pinned commit
#   INSTALL_DIR         ${_clhep_install}
#   CMAKE_ARGS
#     -DCMAKE_INSTALL_PREFIX=${_clhep_install}
#     -DCMAKE_POSITION_INDEPENDENT_CODE=ON
#     -DBUILD_SHARED_LIBS=OFF
#     -DBUILD_TESTING=OFF
# )
#
# set(_incs "${_clhep_install}/include")
# add_library(clhep_headers_ifc INTERFACE)
# add_dependencies(clhep_headers_ifc clhep_external-install)
# target_include_directories(clhep_headers_ifc INTERFACE "${_incs}")
#
# function(_clhep_make_target pkg)
#   string(TOLOWER "${pkg}" _lc)
#   set(_lib "${_clhep_install}/lib/libCLHEP-${pkg}-${_clhep_ver}.a")
#
#   add_library(clhep_${_lc}_static STATIC IMPORTED GLOBAL)
#   set_target_properties(clhep_${_lc}_static PROPERTIES
#       IMPORTED_LOCATION             "${_lib}")
#
#   target_include_directories(clhep_${_lc}_static INTERFACE
#       $<BUILD_INTERFACE:${_clhep_src}>
#       $<INSTALL_INTERFACE:include>)
#
#   add_dependencies(clhep_${_lc}_static clhep_headers_ifc)
#   add_dependencies(clhep_${_lc}_static clhep_external-install)
#   target_link_libraries(clhep_${_lc}_static INTERFACE clhep_headers_ifc)
#
#   # Namespaced alias the rest of the project will use
#   add_library(CLHEP::${pkg} ALIAS clhep_${_lc}_static)
#   add_library(CLHEP::${pkg}S ALIAS clhep_${_lc}_static)
# endfunction()
#
# # Declare only the packages you actually need
# foreach(_pkg IN ITEMS Units Utility Vector Geometry Random Matrix)
#   _clhep_make_target(${_pkg})
# endforeach()

# ====================================================================== #
# CppUnit – LibreOffice fork (autotools), static-only                    #
# ====================================================================== #

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

# macros that are always true on modern toolchains
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
