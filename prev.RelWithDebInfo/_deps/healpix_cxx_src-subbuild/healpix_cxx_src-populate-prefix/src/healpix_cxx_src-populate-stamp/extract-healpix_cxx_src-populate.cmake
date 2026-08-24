# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# Make file names absolute:
#
get_filename_component(filename "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/healpix_cxx_src-subbuild/healpix_cxx_src-populate-prefix/src/Healpix_3.31_2016Aug26.tar.gz" ABSOLUTE)
get_filename_component(directory "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/healpix_cxx_src-src" ABSOLUTE)

message(VERBOSE "extracting...
     src='${filename}'
     dst='${directory}'"
)

if(NOT EXISTS "${filename}")
  message(FATAL_ERROR "File to extract does not exist: '${filename}'")
endif()

# Prepare a space for extracting:
#
set(i 1234)
while(EXISTS "${directory}/../ex-healpix_cxx_src-populate${i}")
  math(EXPR i "${i} + 1")
endwhile()
set(ut_dir "${directory}/../ex-healpix_cxx_src-populate${i}")
file(MAKE_DIRECTORY "${ut_dir}")

# Extract it:
#
message(VERBOSE "extracting... [tar xf]")
execute_process(COMMAND ${CMAKE_COMMAND} -E tar xf ${filename} 
  WORKING_DIRECTORY ${ut_dir}
  RESULT_VARIABLE rv
)

if(NOT rv EQUAL 0)
  message(VERBOSE "extracting... [error clean up]")
  file(REMOVE_RECURSE "${ut_dir}")
  message(FATAL_ERROR "Extract of '${filename}' failed")
endif()

# Analyze what came out of the tar file:
#
message(VERBOSE "extracting... [analysis]")
file(GLOB contents "${ut_dir}/*")
list(REMOVE_ITEM contents "${ut_dir}/.DS_Store")
list(LENGTH contents n)
if(NOT n EQUAL 1 OR NOT IS_DIRECTORY "${contents}")
  set(contents "${ut_dir}")
endif()

# Move "the one" directory to the final directory:
#
message(VERBOSE "extracting... [rename]")
file(REMOVE_RECURSE ${directory})
get_filename_component(contents ${contents} ABSOLUTE)
file(RENAME ${contents} ${directory})

# Clean up:
#
message(VERBOSE "extracting... [clean up]")
file(REMOVE_RECURSE "${ut_dir}")

message(VERBOSE "extracting... done")
