# Install script for directory: /Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3.12/site-packages/fermitools" TYPE FILE FILES
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/AddCatalogSourcesDialog.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/CatalogSourceExtractor.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/DS9Connector.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/Element.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/ElementEditor.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/FitsFile.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/HelpWindow.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/ModelEditor.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/Parameter.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/ParameterEditor.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/ParameterSet.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/Source.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/SourceEditor.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/SourceLibrary.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/SourceLibraryDocument.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/SourceLibraryDocumentEditor.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/SourceLibraryEditor.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/SpatialModel.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/SpatialModelEditor.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/Spectrum.py"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/SpectrumEditor.py"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/fermitools/data/modelEditor" TYPE FILE FILES
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/source_library.xsd"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/source_library_obssim.xsd"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/fermitools/refdata/fermi/modelEditor" TYPE FILE FILES
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/source_library.xsd"
    "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/src/modelEditor/source_library_obssim.xsd"
    )
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/modelEditor/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
