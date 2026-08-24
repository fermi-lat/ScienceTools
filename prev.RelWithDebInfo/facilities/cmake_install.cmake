# Install script for directory: /Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/facilities

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/fermitools" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/facilities/facilities")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3.12/site-packages/fermitools" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/facilities/python/")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities/libfacilities.dylib")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libfacilities.dylib" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libfacilities.dylib")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libfacilities.dylib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" -x "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libfacilities.dylib")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE MODULE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities/_py_facilities.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/_py_facilities.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/_py_facilities.so")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/_py_facilities.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" -x "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/_py_facilities.so")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities/test_env")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_env" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_env")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_env")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_env")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities/test_time")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_time" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_time")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_time")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_time")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities/test_Util")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_Util" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_Util")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_Util")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_Util")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3.12/site-packages/fermitools" TYPE FILE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities/py_facilities.py")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
