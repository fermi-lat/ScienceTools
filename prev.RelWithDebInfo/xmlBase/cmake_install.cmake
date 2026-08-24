# Install script for directory: /Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/xmlBase

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/fermitools" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/xmlBase/xmlBase")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/fermitools/xml/fermi/xmlBase" TYPE DIRECTORY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/xmlBase/xml/")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase/libxmlBase.dylib")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libxmlBase.dylib" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libxmlBase.dylib")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libxmlBase.dylib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" -x "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libxmlBase.dylib")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase/entity_test")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/entity_test" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/entity_test")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/entity_test")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/entity_test")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase/test_mem")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_mem" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_mem")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_mem")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_mem")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase/test_IFile")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_IFile" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_IFile")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_IFile")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_IFile")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase/test_write")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_write" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_write")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_write")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_write")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase/test_parse")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_parse" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_parse")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_parse")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_parse")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase/test_xmlBase")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_xmlBase" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_xmlBase")
    execute_process(COMMAND /Users/jamrhein/miniforge3/envs/fermi-0819master/bin/install_name_tool
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase"
      -delete_rpath "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/facilities"
      -add_rpath "/Users/jamrhein/miniforge3/envs/fermi-0819master/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_xmlBase")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/jamrhein/miniforge3/envs/fermi-0819master/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/test_xmlBase")
    endif()
  endif()
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/xmlBase/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
