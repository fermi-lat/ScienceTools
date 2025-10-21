# Fermitools CMAKE build system Author: Alexander Reustle (2022)
cmake_minimum_required(VERSION 3.20)

project(
  fermitools
  VERSION 2.4.0
  LANGUAGES CXX C
  DESCRIPTION "Fermi Sciencetools")
cmake_policy(SET CMP0120 NEW)
set(CMAKE_POLICY_VERSION_MINIMUM 3.10)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "Override C++ standard" FORCE)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")

# Optional: forcibly propagate to all targets
add_compile_options("$<$<COMPILE_LANGUAGE:CXX>:-std=c++17>")

find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
  message(STATUS "Found ccache in ${CCACHE_PROGRAM}")
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif()

# Options. Activate at configure time with `-D<OPTION>=ON`
option(FERMI_BUILD_ROOT "Build the CERN ROOT components. Requires ROOT!" OFF)
option(CMAKE_CXX_COMPILER "Specify Compiler" clang)

# CMake tool support packages. These provide additional funcitons to our Cmake
# files.
include(CMakeDependentOption)
include(CheckCXXCompilerFlag)
include(GNUInstallDirs)
include(CTest)

# The local cmake modules path.
list(INSERT CMAKE_MODULE_PATH 0 ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

#######################################################################
# Externals: The dependent packages on which the Sciencetools relies. #
#######################################################################

find_package(Threads REQUIRED)
find_package(OpenMP REQUIRED COMPONENTS CXX)

find_package(SWIG 3.0.1 REQUIRED COMPONENTS python)
set(UseSWIG_TARGET_NAME_PREFERENCE STANDARD)

# Python3 External development headers.
set(Python3_FIND_VIRTUALENV FIRST)

find_package(Python3 3.7 REQUIRED COMPONENTS Development Interpreter)

set_target_properties(Python3::Python PROPERTIES IMPORTED_GLOBAL TRUE)

if(NOT APPLE)
  option(USE_SYSTEM_CFITSIO     "Use system-installed cfitsio instead of package-provided" OFF)
  option(USE_SYSTEM_XERCES_C    "Use system-installed XercesC instead of package-provided" ON)
else()
  option(USE_SYSTEM_CFITSIO     "Use system-installed cfitsio instead of package-provided" ON)
endif()

# --------------------------------------------------------------------
# Allow user to pick system vs vendored for each library:
option(USE_SYSTEM_CLHEP       "Use system-installed CLHEP instead of package-provided" OFF)
option(USE_SYSTEM_CPPUNIT     "Use system-installed CppUnit instead of package-provided" OFF)
option(USE_SYSTEM_F2C         "Use system-installed f2x instead of package-provided" OFF)
option(USE_SYSTEM_FFTW        "Use system-installed fftw instead of package-provided" OFF)
option(USE_SYSTEM_GSL         "Use system-installed gsl instead of package-provided" OFF)
option(USE_SYSTEM_HEALPIX_CXX "Use system-installed healpix_cxx instead of package-provided" OFF)
option(USE_SYSTEM_WCSLIB      "Use system-installed WCSlib instead of package-provided" OFF)
# option(USE_SYSTEM_XERCES_C    "Use system-installed XercesC instead of package-provided" OFF)

# --------------------------------------------------------------------
# Helper macro to switch
macro(add_or_find lib_name option_var find_module module_target)
  if(${option_var})
    find_package(${find_module} REQUIRED)
    set_target_properties(${module_target} PROPERTIES IMPORTED_GLOBAL TRUE)
  else()
    add_subdirectory(externals/${lib_name})
  endif()
endmacro()

# -------------------------------------------------------------------------------------
add_or_find(cfitsio      USE_SYSTEM_CFITSIO      cfitsio      cfitsio::cfitsio)
add_or_find(clhep        USE_SYSTEM_CLHEP        CLHEP        CLHEP::CLHEP)
add_or_find(cppunit      USE_SYSTEM_CPPUNIT      CppUnit      CppUnit::CppUnit)
add_or_find(f2c          USE_SYSTEM_F2C          f2c          f2c::f2c)
add_or_find(fftw         USE_SYSTEM_FFTW         FFTW         FFTW::fftw3)
add_or_find(gsl          USE_SYSTEM_GSL          GSL          GSL::gsl)
add_or_find(healpix_cxx  USE_SYSTEM_HEALPIX_CXX  healpix_cxx  healpix_cxx::healpix_cxx)
add_or_find(wcslib       USE_SYSTEM_WCSLIB       WCSlib       WCSlib::WCSlib)
add_or_find(xercesc      USE_SYSTEM_XERCES_C     XercesC      XercesC::XercesC)
# -------------------------------------------------------------------------------------

# Handle root.
if(FERMI_BUILD_ROOT)
  find_package(ROOT REQUIRED)
  set_target_properties(ROOT::Core PROPERTIES IMPORTED_GLOBAL TRUE)
endif()

if(NOT APPLE)
  add_compile_definitions(TRAP_FPE)
endif()

# ##############################################################################
# Specify Installation destinations
# ##############################################################################

include(GNUInstallDirs)
set(CONFIG_INSTALLDIR lib/cmake/${PROJECT_NAME})
set(PYTHON_SITE_PKGDIR
    lib/python${Python3_VERSION_MAJOR}.${Python3_VERSION_MINOR}/site-packages)
set(FERMI_INSTALL_PYTHON ${PYTHON_SITE_PKGDIR}/${PROJECT_NAME})
set(FERMI_INSTALL_INCLUDEDIR ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
set(FERMI_INSTALL_DATADIR share/${PROJECT_NAME}/data)
set(FERMI_INSTALL_REFDATADIR share/${PROJECT_NAME}/refdata/fermi)
set(FERMI_INSTALL_HELPDIR share/${PROJECT_NAME}/help)
set(FERMI_INSTALL_PFILESDIR share/${PROJECT_NAME}/syspfiles)
set(FERMI_INSTALL_XMLDIR share/${PROJECT_NAME}/xml/fermi)

# ##############################################################################
# Targets The full colleciton of Sciencetools packages.
list(
  APPEND
  FERMI_COMPONENTS
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
  sourceIdentify
  SolarSystemTools
  st_facilities
  st_stream
  st_graph
  st_app
  tip
  timeSystem
  xmlBase)

list(JOIN FERMI_COMPONENTS " " FERMI_COMPONENTS_SPACES)

# Configuration ####
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.h.in config.h)
include_directories(${CMAKE_BINARY_PATH})

# ##############################################################################
foreach(pkg ${FERMI_COMPONENTS})
  add_subdirectory(src/${pkg} ${CMAKE_BINARY_DIR}/${pkg})
endforeach()

# Install #######

# Add the init.py file to the installed target python site-packages dir.
install(CODE "file(TOUCH ${CMAKE_BINARY_DIR}/__init__.py)")
install(FILES "${CMAKE_BINARY_DIR}/__init__.py"
        DESTINATION ${FERMI_INSTALL_PYTHON})
# Add the fermitools.pth file to lib

install(
  CODE "file(WRITE ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pth ${PROJECT_NAME}\\n)")
install(
  CODE "file(APPEND ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pth ../../../lib/\\n)")
install(
  CODE "file(APPEND ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pth ../../../lib/${PROJECT_NAME}\\n)"
)
install(FILES "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pth"
        DESTINATION ${PYTHON_SITE_PKGDIR})
