# Fermitools CMAKE build system
# Author: Alexander Reustle (2022)
cmake_minimum_required(VERSION 3.18)

project(
  fermitools
  VERSION 2.4.1
  LANGUAGES CXX C
  DESCRIPTION "Fermitools"
)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Further debugging options
# set(CMAKE_VERBOSE_MAKEFILE ON)
# set(CMAKE_EXECUTE_PROCESS_COMMAND_ECHO STDOUT)

# Give Python Tests access to the same PROJECT information via SHELL environment variables.
set(ENV{PY_PROJECT_NAME} ${PROJECT_NAME})
set(ENV{PY_PROJECT_VERSION} ${PROJECT_VERSION})
set(ENV{PY_PROJECT_DESCRIPTION} ${PROJECT_DESCRIPTION})

# This approach updates a list of Templates/tpl files found in 
execute_process(
        COMMAND python3 ${CMAKE_CURRENT_SOURCE_DIR}/python/update_template_creator.py ${PROJECT_DESCRIPTION} ${PROJECT_VERSION} 
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        RESULT_VARIABLE script_result
        OUTPUT_VARIABLE script_output
        ERROR_VARIABLE script_error
)

# Results from running update_template_creator.py
message(STATUS "Execute Process output: ${script_output}")
message(STATUS "Execute Process err: ${script_error}")
message(STATUS "Execute Process res: ${script_result}")


find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    message(STATUS "Found ccache in ${CCACHE_PROGRAM}")
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif()

## Options. Activate at configure time with `-D<OPTION>=ON`
option(FERMI_BUILD_ROOT "Build the CERN ROOT components. Requires ROOT!" OFF)
option(CMAKE_CXX_COMPILER "Specify Compiler" clang)

## CMake tool support packages. These provide additional funcitons to our Cmake files.
include(CMakeDependentOption)
include(CheckCXXCompilerFlag)
include(GNUInstallDirs)
include(CTest)

## The local cmake modules path.
list(INSERT CMAKE_MODULE_PATH 0 ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

## Externals: The dependent packages on which the Sciencetools relies. ##
find_package(cfitsio 4.0.0 REQUIRED)
find_package(CLHEP REQUIRED)
find_package(CppUnit REQUIRED)
find_package(f2c REQUIRED)
find_package(FFTW REQUIRED)
find_package(GSL REQUIRED)
find_package(healpix_cxx REQUIRED)
find_package(OpenMP REQUIRED COMPONENTS CXX)
find_package(SWIG 3.0.1 REQUIRED COMPONENTS python)
set(UseSWIG_TARGET_NAME_PREFERENCE STANDARD)
# Python3 External development headers.
set(Python3_FIND_VIRTUALENV FIRST)
find_package(Python3 3.7 REQUIRED COMPONENTS Development Interpreter)
find_package(WCSlib REQUIRED)
find_package(XercesC REQUIRED)

## Make the targets visible in other CMake files.
set_target_properties(
  cfitsio::cfitsio
  CLHEP::CLHEP
  CppUnit::CppUnit
  f2c::f2c
  FFTW::fftw3
  GSL::gsl
  healpix_cxx::healpix_cxx
  Python3::Python
  WCSlib::WCSlib
  XercesC::XercesC
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

## Floating-point exceptions (like division by zero, overflow, or invalid operations)
## TRAP_FPE isn't a standard, universally available flag across all compilers or systems.
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
  general_util
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
  skymaps
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
