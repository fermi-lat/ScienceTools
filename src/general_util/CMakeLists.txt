cmake_minimum_required(VERSION 3.10) # Minimum required CMake version
project(general_util LANGUAGES CXX)      # Project name and languages

# set(FERMI_INSTALL_INCLUDEDIR ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})

# Define source files for the library
add_library(general_util STATIC
    src/generic_utils.cxx
)

target_include_directories(
  general_util PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:>
  ${CMAKE_BINARY_DIR}
)

# target_link_libraries(
#   general_util 
#   PRIVATE dgaus8 cfitsio::cfitsio tip
#   PUBLIC astro GSL::gsl
# )

target_compile_definitions(general_util PUBLIC ScienceTools)

add_executable(test_general_util src/test/GenericUtilsTest.cxx)
target_link_libraries(test_general_util PRIVATE general_util CppUnit::CppUnit)

target_include_directories(
  test_general_util PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
  $<INSTALL_INTERFACE:>
)

# if(NOT APPLE)
#   target_compile_definitions(general_util PRIVATE TRAP_FPE)
# endif()

###############################################################
# Installation
###############################################################
install(DIRECTORY general_util DESTINATION ${FERMI_INSTALL_INCLUDEDIR})

install(
  TARGETS general_util test_general_util
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
