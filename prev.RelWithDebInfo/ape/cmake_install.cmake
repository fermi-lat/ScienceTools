# Install script for directory: /Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/ape

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/ape/include/ape")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/ape/include/pil.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/ape/include/pil_error.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/libape_3.dylib")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libape_3.dylib" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libape_3.dylib")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libape_3.dylib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" -x "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libape_3.dylib")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/pcheck")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pcheck" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pcheck")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pcheck")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pcheck")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/pget")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pget" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pget")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pget")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pget")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/plist")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/plist" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/plist")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/plist")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/plist")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/pquery")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pquery" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pquery")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pquery")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pquery")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/pquery2")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pquery2" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pquery2")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pquery2")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pquery2")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/pset")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pset" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pset")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pset")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pset")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/punlearn")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/punlearn" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/punlearn")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/punlearn")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/punlearn")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/ape/apeTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/ape/apeTargets.cmake"
         "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/CMakeFiles/Export/923ba4f628606505b22573e2b4994abc/apeTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/ape/apeTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/ape/apeTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/ape" TYPE FILE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/CMakeFiles/Export/923ba4f628606505b22573e2b4994abc/apeTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/ape" TYPE FILE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/CMakeFiles/Export/923ba4f628606505b22573e2b4994abc/apeTargets-relwithdebinfo.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/ape" TYPE FILE FILES
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/apeConfig.cmake"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/apeConfigVersion.cmake"
    )
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/ape/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
