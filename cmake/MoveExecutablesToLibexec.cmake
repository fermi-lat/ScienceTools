# Install-time script: move the compiled executables this project installed into bin/ to
# libexec/fermitools/, and leave a small shell wrapper with the same name in bin/ that runs them.
#
# The conda package is Python version independent (CEP 20, build/python_version_independent in
# recipe/meta.yaml). conda-build treats every file in bin/ of such a package as a Python script and
# refuses compiled ones, so the real programs must live outside bin/. The wrappers keep the tools on
# PATH, with or without `conda activate`.
#
# Only files installed by this project (the install manifest so far) are touched.

set(bin_dir "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin")
set(libexec_dir "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/libexec/fermitools")

foreach(installed_file IN LISTS CMAKE_INSTALL_MANIFEST_FILES)
  get_filename_component(dir "${installed_file}" DIRECTORY)
  if(NOT dir STREQUAL bin_dir OR IS_SYMLINK "${installed_file}" OR NOT EXISTS "${installed_file}")
    continue()
  endif()

  # Only compiled programs: ELF (Linux), thin 64-bit or universal Mach-O (macOS).
  file(READ "${installed_file}" magic LIMIT 4 HEX)
  if(NOT magic MATCHES "^(7f454c46|cffaedfe|cafebabe)$")
    continue()
  endif()

  get_filename_component(name "${installed_file}" NAME)
  file(MAKE_DIRECTORY "${libexec_dir}")
  file(RENAME "${installed_file}" "${libexec_dir}/${name}")

  file(WRITE "${installed_file}"
    "#!/bin/sh\n"
    "# fermitools: the real program is libexec/fermitools/${name} (see cmake/MoveExecutablesToLibexec.cmake).\n"
    "exec \"$(dirname \"$0\")/../libexec/fermitools/${name}\" \"$@\"\n")
  file(CHMOD "${installed_file}"
    PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
  message(STATUS "Moved ${name} to libexec/fermitools and installed a wrapper in bin")
endforeach()
