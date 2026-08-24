# Install script for directory: /Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/externals/cfitsio/cfitsio

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/libcfitsio.a")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcfitsio.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcfitsio.a")
    execute_process(COMMAND "/opt/homebrew/opt/llvm/bin/llvm-ranlib" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcfitsio.a")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Devel" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/externals/cfitsio/cfitsio/fitsio.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/externals/cfitsio/cfitsio/fitsio2.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/externals/cfitsio/cfitsio/longnam.h"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/cfitsio_export.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/cfitsio/cfitsioTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/cfitsio/cfitsioTargets.cmake"
         "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/CMakeFiles/Export/5661b2443b6a5fc8d92ea639e23253a8/cfitsioTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/cfitsio/cfitsioTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/cfitsio/cfitsioTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/cfitsio" TYPE FILE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/CMakeFiles/Export/5661b2443b6a5fc8d92ea639e23253a8/cfitsioTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/cfitsio" TYPE FILE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/CMakeFiles/Export/5661b2443b6a5fc8d92ea639e23253a8/cfitsioTargets-relwithdebinfo.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Devel" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/cfitsio" TYPE FILE FILES
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/externals/cfitsio/cfitsio/cmake/cfitsioConfig.cmake"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/cfitsio/cfitsioConfigVersion.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/cfitsio.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/fpack")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fpack" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fpack")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fpack")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fpack")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/funpack")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/funpack" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/funpack")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/funpack")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/funpack")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/fitscopy")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fitscopy" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fitscopy")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fitscopy")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fitscopy")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/fitsverify")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fitsverify" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fitsverify")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fitsverify")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fitsverify")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/imcopy")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/imcopy" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/imcopy")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/imcopy")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/imcopy")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/speed")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/speed" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/speed")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/speed")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/speed")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/smem")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/smem" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/smem")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/smem")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/smem")
    endif()
  endif()
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/externals/cfitsio/cfitsio/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
