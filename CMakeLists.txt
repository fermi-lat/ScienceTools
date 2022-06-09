# Fermitools CMAKE build system
# Author: Alexander Reustle (2022)
cmake_minimum_required(VERSION 3.18)

project(
  fermitools
  VERSION 2.1.0
  LANGUAGES CXX C
  DESCRIPTION "Fermi Sciencetools"
)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

## Options. Activate at configure time with `-D<OPTION>=ON`
option(FERMI_BUILD_ROOT "Build the CERN ROOT components. Requires ROOT!" OFF)

## CMake tool support packages. These provide additional funcitons to our Cmake files.
include(CMakePackageConfigHelpers)
include(CMakeDependentOption)
include(CheckCXXCompilerFlag)
include(GNUInstallDirs)
include(CTest)

## The local cmake modules path.
list(INSERT CMAKE_MODULE_PATH 0 ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

## Externals: The dependent packages on which the Sciencetools relies. ##
find_package(CLHEP REQUIRED)
find_package(f2c REQUIRED)
find_package(OpenMP REQUIRED COMPONENTS CXX)
find_package(PkgConfig REQUIRED)
find_package(SWIG 3.0.1 REQUIRED COMPONENTS python)
set(UseSWIG_TARGET_NAME_PREFERENCE STANDARD)
set(Python3_FIND_VIRTUALENV FIRST)
find_package(Python3 3.7 REQUIRED COMPONENTS Development Interpreter)

## Pkg-Config Externals ##
pkg_check_modules(cfitsio REQUIRED IMPORTED_TARGET GLOBAL cfitsio)
pkg_check_modules(cppunit REQUIRED IMPORTED_TARGET GLOBAL cppunit)
pkg_check_modules(fftw3 REQUIRED IMPORTED_TARGET GLOBAL fftw3)
pkg_check_modules(gsl REQUIRED IMPORTED_TARGET GLOBAL gsl)
pkg_check_modules(wcslib REQUIRED IMPORTED_TARGET GLOBAL wcslib)
pkg_check_modules(healpix_cxx REQUIRED IMPORTED_TARGET GLOBAL healpix_cxx)
pkg_check_modules(xerces-c REQUIRED IMPORTED_TARGET GLOBAL xerces-c)

## Make the targets visible in other CMake files.
set_target_properties(
  CLHEP::CLHEP
  f2c::f2c
  OpenMP::OpenMP_CXX
  Python3::Python
  PROPERTIES IMPORTED_GLOBAL TRUE
)

## Handle root.
if(FERMI_BUILD_ROOT)
  find_package(ROOT REQUIRED)
  set_target_properties(
    ROOT::Core
    PROPERTIES IMPORTED_GLOBAL TRUE
  )
endif()


if(NOT APPLE)
  add_compile_definitions(TRAP_FPE)
endif()

###############################################################################
# Specify Installation destinations
###############################################################################

include(GNUInstallDirs)
set(CONFIG_INSTALLDIR lib/cmake/${PROJECT_NAME})
set(
  PYTHON_SITE_PKGDIR
  lib/python${Python3_VERSION_MAJOR}.${Python3_VERSION_MINOR}/site-packages
)
set(FERMI_INSTALL_PYTHON ${PYTHON_SITE_PKGDIR}/${PROJECT_NAME})
set(FERMI_INSTALL_INCLUDEDIR ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
set(FERMI_INSTALL_DATADIR share/${PROJECT_NAME}/data)
set(FERMI_INSTALL_REFDATADIR share/${PROJECT_NAME}/refdata/fermi)
set(FERMI_INSTALL_HELPDIR share/${PROJECT_NAME}/help)
set(FERMI_INSTALL_PFILESDIR share/${PROJECT_NAME}/syspfiles)
set(FERMI_INSTALL_XMLDIR share/${PROJECT_NAME}/xml/fermi)


set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" isSystemDir)
if("${isSystemDir}" STREQUAL "-1")
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
endif()

##################################################
## Targets
## The full colleciton of Sciencetools packages.
list(
  APPEND FERMI_COMPONENTS
  ape
  astro
  BayesianBlocks
  burstFit
  catalogAccess
  celestialSources
  dataSubselector
  embed_python
  evtbin
  facilities
  fermitools-fhelp
  fitsGen
  flux
  healpix
  hoops
  irfs
  Likelihood
  map_tools
  Minuit2
  modelEditor
  observationSim
  optimizers
  orbitSim
  pulsarDb
  pulsePhase
  pyBurstAnalysisGUI
  pyExposure
  pyLikelihood
  rspgen
  sane
  # skymaps
  sourceIdentify
  SolarSystemTools
  st_facilities
  st_stream
  st_graph
  st_app
  tip
  timeSystem
  xmlBase
)

list(JOIN FERMI_COMPONENTS " " FERMI_COMPONENTS_SPACES)

#### Configuration ####
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.h.in config.h)
include_directories(${CMAKE_BINARY_PATH})


#######################
foreach(pkg ${FERMI_COMPONENTS})
  add_subdirectory(src/${pkg} ${CMAKE_BINARY_DIR}/${pkg})
endforeach()

####### Install #######

# Add the init.py file to the installed target python site-packages dir.
install(CODE "file(TOUCH ${CMAKE_BINARY_DIR}/__init__.py)")
install(FILES "${CMAKE_BINARY_DIR}/__init__.py" DESTINATION ${FERMI_INSTALL_PYTHON})
# Add the fermitools.pth file to lib

install(CODE "file(WRITE ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pth ${PROJECT_NAME}\\n)")
install(CODE "file(APPEND ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pth ../../../lib/\\n)")
install(CODE "file(APPEND ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pth ../../../lib/${PROJECT_NAME}\\n)")
install(
  FILES "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pth"
  DESTINATION ${PYTHON_SITE_PKGDIR}
)
