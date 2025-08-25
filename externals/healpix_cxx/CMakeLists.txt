# =========================================================================== #
# Healpix_cxx 3.31
# =========================================================================== #

include(FetchContent)

message(STATUS "Local External Dependency Healpix_cxx version 3.31")

FetchContent_Declare(
  healpix_cxx_src
  URL https://downloads.sourceforge.net/project/healpix/Healpix_3.31/Healpix_3.31_2016Aug26.tar.gz
  URL_HASH
    SHA256=ddf437442b6d5ae7d75c9afaafc4ec43921f903c976e25db3c5ed5185a181542
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  PATCH_COMMAND patch -p0 < ${CMAKE_CURRENT_SOURCE_DIR}/healpix_cxx.patch)

FetchContent_MakeAvailable(healpix_cxx_src)

set(HPIXCXX_SRC "${healpix_cxx_src_SOURCE_DIR}/src/cxx")

# --- Source Lists ---

set(HPIX_CUTIL_SRC c_utils.c walltime_c.c)
list(TRANSFORM HPIX_CUTIL_SRC PREPEND "${HPIXCXX_SRC}/c_utils/")

set(HPIX_FFT_SRC bluestein.c fftpack.c ls_fft.c)
list(TRANSFORM HPIX_FFT_SRC PREPEND "${HPIXCXX_SRC}/libfftpack/")

set(HPIX_SHARP_SRC sharp.c sharp_almhelpers.c sharp_core.c sharp_geomhelpers.c
                   sharp_ylmgen_c.c)
list(TRANSFORM HPIX_SHARP_SRC PREPEND "${HPIXCXX_SRC}/libsharp/")

set(HPIX_CXXSUP_SRC
    announce.cc
    fitshandle.cc
    geom_utils.cc
    string_utils.cc
    ls_image.cc
    paramfile.cc
    pointing.cc
    rotmatrix.cc
    trafos.cc
    walltimer.cc
    wigner.cc
    error_handling.cc)
list(TRANSFORM HPIX_CXXSUP_SRC PREPEND "${HPIXCXX_SRC}/cxxsupport/")

set(HPIX_HPIXCXX_SRC
    alm.cc
    alm2map_cxx_module.cc
    alm_fitsio.cc
    alm_healpix_tools.cc
    alm_powspec_tools.cc
    anafast_cxx_module.cc
    calc_powspec_module.cc
    healpix_base.cc
    healpix_data_io.cc
    healpix_map.cc
    healpix_map_fitsio.cc
    healpix_tables.cc
    hotspots_cxx_module.cc
    map2tga_module.cc
    median_filter_cxx_module.cc
    mult_alm_module.cc
    powspec.cc
    powspec_fitsio.cc
    smoothing_cxx_module.cc
    syn_alm_cxx_module.cc
    udgrade_cxx_module.cc
    udgrade_harmonic_cxx_module.cc
    moc_query.cc
    moc_fitsio.cc)
list(TRANSFORM HPIX_HPIXCXX_SRC PREPEND "${HPIXCXX_SRC}/Healpix_cxx/")

# --- Object Libraries ---

add_library(_hpix_c_util OBJECT ${HPIX_CUTIL_SRC})
target_include_directories(_hpix_c_util PRIVATE "${HPIXCXX_SRC}/c_utils")

add_library(_hpix_fft OBJECT ${HPIX_FFT_SRC})
target_include_directories(_hpix_fft PRIVATE "${HPIXCXX_SRC}/libfftpack"
                                             "${HPIXCXX_SRC}/c_utils")

add_library(_hpix_sharp OBJECT ${HPIX_SHARP_SRC})
target_include_directories(
  _hpix_sharp PRIVATE "${HPIXCXX_SRC}/libsharp" "${HPIXCXX_SRC}/libfftpack"
                      "${HPIXCXX_SRC}/c_utils")

add_library(_hpix_cxxsup OBJECT ${HPIX_CXXSUP_SRC})
target_include_directories(_hpix_cxxsup PRIVATE "${HPIXCXX_SRC}/cxxsupport"
                                                "${HPIXCXX_SRC}/c_utils")
target_link_libraries(_hpix_cxxsup PRIVATE cfitsio::cfitsio)

add_library(_hpix_hpixcxx OBJECT ${HPIX_HPIXCXX_SRC})
target_include_directories(
  _hpix_hpixcxx
  PRIVATE "${HPIXCXX_SRC}/Healpix_cxx" "${HPIXCXX_SRC}/cxxsupport"
          "${HPIXCXX_SRC}/c_utils" "${HPIXCXX_SRC}/libfftpack"
          "${HPIXCXX_SRC}/libsharp")

add_library(
  healpix_cxx STATIC
  "$<TARGET_OBJECTS:_hpix_c_util>" "$<TARGET_OBJECTS:_hpix_fft>"
  "$<TARGET_OBJECTS:_hpix_sharp>" "$<TARGET_OBJECTS:_hpix_cxxsup>"
  "$<TARGET_OBJECTS:_hpix_hpixcxx>")
target_include_directories(
  healpix_cxx
  PUBLIC "${HPIXCXX_SRC}/Healpix_cxx" "${HPIXCXX_SRC}/cxxsupport"
         "${HPIXCXX_SRC}/libfftpack" "${HPIXCXX_SRC}/libsharp"
         "${HPIXCXX_SRC}/c_utils")

add_library(healpix_cxx::healpix_cxx ALIAS healpix_cxx)
