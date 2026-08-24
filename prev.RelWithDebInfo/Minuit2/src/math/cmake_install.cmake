# Install script for directory: /Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/src/math

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/Users/jamrhein/miniforge3/envs/fermi-0819master")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/opt/homebrew/opt/llvm/bin/llvm-objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Minuit2/src/math/libFermiMinuit2Math.a")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libFermiMinuit2Math.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libFermiMinuit2Math.a")
    execute_process(COMMAND "/opt/homebrew/opt/llvm/bin/llvm-ranlib" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libFermiMinuit2Math.a")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/fermi/Minuit2/Fit" TYPE FILE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Fit/ParameterSettings.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/fermi/Minuit2/Math" TYPE FILE FILES
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/Error.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/FitMethodFunction.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/Functor.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/GenAlgoOptions.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/IFunction.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/IFunctionfwd.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/IOptions.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/Minimizer.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/MinimizerOptions.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/Util.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/WrappedFunction.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Minuit2/inc/Math/WrappedParamFunction.h"
    )
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Minuit2/src/math/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
