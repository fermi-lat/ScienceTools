# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/fftw-src")
  file(MAKE_DIRECTORY "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/fftw-src")
endif()
file(MAKE_DIRECTORY
  "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/fftw-build"
  "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/fftw-subbuild/fftw-populate-prefix"
  "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/fftw-subbuild/fftw-populate-prefix/tmp"
  "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/fftw-subbuild/fftw-populate-prefix/src/fftw-populate-stamp"
  "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/fftw-subbuild/fftw-populate-prefix/src"
  "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/fftw-subbuild/fftw-populate-prefix/src/fftw-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/fftw-subbuild/fftw-populate-prefix/src/fftw-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/Users/jamrhein/FALL_2026_Builds/0819/ScienceTools/RelWithDebInfo/_deps/fftw-subbuild/fftw-populate-prefix/src/fftw-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
