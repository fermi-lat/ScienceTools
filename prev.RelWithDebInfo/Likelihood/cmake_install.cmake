# Install script for directory: /Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Likelihood

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/fermitools" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Likelihood/Likelihood")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/fermitools/refdata/fermi/Likelihood" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Likelihood/data/")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/fermitools/syspfiles" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Likelihood/pfiles/")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/fermitools/xml/fermi/Likelihood" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/Likelihood/xml/")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/libLikelihood.dylib")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libLikelihood.dylib" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libLikelihood.dylib")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libLikelihood.dylib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" -x "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libLikelihood.dylib")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtlike")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtlike" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtlike")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtlike")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtlike")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtexpmap")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtexpmap" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtexpmap")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtexpmap")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtexpmap")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gttsmap")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gttsmap" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gttsmap")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gttsmap")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gttsmap")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gttscube")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gttscube" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gttscube")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gttscube")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gttscube")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gthealcube")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gthealcube" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gthealcube")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gthealcube")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gthealcube")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtltcube")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtltcube" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtltcube")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtltcube")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtltcube")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtexpcube2")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtexpcube2" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtexpcube2")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtexpcube2")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtexpcube2")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtdiffrsp")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtdiffrsp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtdiffrsp")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtdiffrsp")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtdiffrsp")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtsrcmaps")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtsrcmaps" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtsrcmaps")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtsrcmaps")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtsrcmaps")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtebl")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtebl" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtebl")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtebl")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtebl")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtsrcprob")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtsrcprob" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtsrcprob")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtsrcprob")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtsrcprob")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtpsf")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtpsf" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtpsf")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtpsf")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtpsf")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtbkg")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbkg" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbkg")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbkg")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbkg")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtmodel")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtmodel" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtmodel")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtmodel")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtmodel")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtltsum")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtltsum" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtltsum")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtltsum")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtltsum")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtfindsrc")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtfindsrc" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtfindsrc")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtfindsrc")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtfindsrc")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gteffbkg")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gteffbkg" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gteffbkg")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gteffbkg")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gteffbkg")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtalphabkg")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtalphabkg" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtalphabkg")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtalphabkg")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtalphabkg")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtwtsmap")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtwtsmap" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtwtsmap")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtwtsmap")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtwtsmap")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/gtdrm")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtdrm" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtdrm")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtdrm")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtdrm")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/test_Likelihood")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_Likelihood" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_Likelihood")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfLoader"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1aResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc1Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/dc2Response"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/testResponse"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/irfs/irfInterface"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_Likelihood")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_Likelihood")
    endif()
  endif()
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/Likelihood/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
