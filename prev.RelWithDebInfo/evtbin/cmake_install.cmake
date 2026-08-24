# Install script for directory: /Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/evtbin

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/fermitools" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/evtbin/evtbin")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/fermitools/syspfiles" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/evtbin/pfiles/")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/fermitools/data/evtbin" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/evtbin/data/outref")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/fermitools/refdata/fermi/evtbin" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/evtbin/data/" REGEX "/outref$" EXCLUDE)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/evtbin/libevtbin.a")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libevtbin.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libevtbin.a")
    execute_process(COMMAND "/opt/homebrew/opt/llvm/bin/llvm-ranlib" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libevtbin.a")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/evtbin/gtbin")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbin" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbin")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbin")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbin")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/evtbin/gtbindef")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbindef" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbindef")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbindef")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/gtbindef")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/evtbin/test_evtbin")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_evtbin" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_evtbin")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/healpix"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/astro"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/tip"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_evtbin")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_evtbin")
    endif()
  endif()
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/evtbin/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
