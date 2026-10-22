# Install-time script (Linux): replace the versioned libpython (e.g. libpython3.12.so.1.0) that the
# installed binaries depend on with the version-independent libpython3.so stub. The stub depends on
# whichever libpython3.X sits next to it, so the binaries load the Python of the environment they are
# run in. This is safe because all code is compiled against the stable ABI (Py_LIMITED_API).
#
# GNU ld cannot resolve symbols through libpython3.so (it only lists libpython3.X as a dependency), so
# the binaries are linked against libpython3.X and the dependency is rewritten here with patchelf.
#
# Expects FERMI_PATCHELF to be set. Only files installed by this project (the install manifest so far)
# are touched, never anything else that happens to live in the install prefix.

foreach(installed_file IN LISTS CMAKE_INSTALL_MANIFEST_FILES)
  if(IS_SYMLINK "${installed_file}" OR IS_DIRECTORY "${installed_file}" OR NOT EXISTS "${installed_file}")
    continue()
  endif()

  # Skip anything that is not an ELF file without spawning patchelf.
  file(READ "${installed_file}" magic LIMIT 4 HEX)
  if(NOT magic STREQUAL "7f454c46")
    continue()
  endif()

  execute_process(
    COMMAND "${FERMI_PATCHELF}" --print-needed "${installed_file}"
    RESULT_VARIABLE result
    OUTPUT_VARIABLE needed
    ERROR_VARIABLE error)
  if(NOT result EQUAL 0)
    message(FATAL_ERROR "patchelf could not read ${installed_file}: ${error}")
  endif()

  string(REGEX MATCH "libpython3\\.[0-9]+\\.so[.0-9]*" versioned "${needed}")
  if(versioned)
    execute_process(
      COMMAND "${FERMI_PATCHELF}" --replace-needed "${versioned}" libpython3.so "${installed_file}"
      RESULT_VARIABLE result
      ERROR_VARIABLE error)
    if(NOT result EQUAL 0)
      message(FATAL_ERROR "patchelf could not update ${installed_file}: ${error}")
    endif()
    message(STATUS "Replaced ${versioned} with libpython3.so: ${installed_file}")
  endif()
endforeach()
