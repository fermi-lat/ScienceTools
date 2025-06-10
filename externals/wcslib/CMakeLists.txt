# =========================================================================== #
# WCSlib
# =========================================================================== #

message(STATUS "Local External Dependency WCSlib")

set(WCS_SRC_C "${CMAKE_CURRENT_SOURCE_DIR}/wcslib/C")

file(GLOB WCS_SOURCES "${WCS_SRC_C}/*.c")

add_library(WCSlib STATIC ${WCS_SOURCES})
target_include_directories(WCSlib
    PUBLIC ${WCS_SRC_C}
    PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/wcslib"
)
target_link_libraries(WCSlib PRIVATE cfitsio::cfitsio)
add_library(WCSlib::WCSlib ALIAS WCSlib)
