# =========================================================================== #
# WCSlib
# =========================================================================== #

message(STATUS "Local External Dependency WCSlib")

set(WCS_SRC_C "${CMAKE_CURRENT_SOURCE_DIR}/wcslib/C")

file(GLOB WCS_SOURCES "${WCS_SRC_C}/*.c")

add_library(WCSlib STATIC ${WCS_SOURCES})
target_include_directories(WCSlib
    PUBLIC
    ${CMAKE_CURRENT_BINARY_DIR}
    ${WCS_SRC_C}
    PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/wcslib"
)

configure_file(${WCS_SRC_C}/wcs.h ${CMAKE_CURRENT_BINARY_DIR}/wcslib/wcs.h COPYONLY)
configure_file(${WCS_SRC_C}/wcshdr.h ${CMAKE_CURRENT_BINARY_DIR}/wcslib/wcshdr.h COPYONLY)

target_link_libraries(WCSlib PRIVATE cfitsio::cfitsio)
add_library(WCSlib::WCSlib ALIAS WCSlib)
