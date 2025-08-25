# =========================================================================== #
# F2C 
# =========================================================================== #

cmake_minimum_required(VERSION 3.14)
cmake_policy(SET CMP0120 NEW)
set(CMAKE_POLICY_VERSION_MINIMUM 3.10)

include(FetchContent)

message(STATUS "Local External Dependency F2C")


FetchContent_Declare(f2c_src
  URL https://web.archive.org/web/20210322095636/https://netlib.sandia.gov/f2c/libf2c.zip
  URL_HASH SHA256=ca404070e9ce0a9aaa6a71fc7d5489d014ade952c5d6de7efb88de8e24f2e8e0
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)

FetchContent_MakeAvailable(f2c_src)

file( WRITE ${f2c_src_SOURCE_DIR}/arith.h
  "#define IEEE_8087
#define Arith_Kind_ASL 1
#define Long int
#define Intcast (int)(long)
#define Double_Align
#define X64_bit_pointers
#define NANCHECK
#define QNaN0 0x0
#define QNaN1 0x7ff80000"
)

file(WRITE ${f2c_src_SOURCE_DIR}/MAIN_stub.c "int MAIN__(int argc, char *argv[]) { return 0; }")
file(COPY_FILE ${f2c_src_SOURCE_DIR}/signal1.h0 ${f2c_src_SOURCE_DIR}/signal1.h)
file(COPY_FILE ${f2c_src_SOURCE_DIR}/sysdep1.h0 ${f2c_src_SOURCE_DIR}/sysdep1.h)
file(COPY_FILE ${f2c_src_SOURCE_DIR}/f2c.h0 ${f2c_src_SOURCE_DIR}/f2c.h)
file(READ ${f2c_src_SOURCE_DIR}/f2ch.add F2CHADD)
file(APPEND ${f2c_src_SOURCE_DIR}/f2c.h "${F2CHADD}")
file(MAKE_DIRECTORY ${f2c_src_SOURCE_DIR}/f2c)
file(COPY_FILE ${f2c_src_SOURCE_DIR}/f2c.h ${f2c_src_SOURCE_DIR}/f2c/f2c.h)

#### Source object groups as defined in makefile.u
set(MISC f77vers.c i77vers.c main.c MAIN_stub.c s_rnge.c abort_.c exit_.c getarg_.c
    iargc_.c getenv_.c signal_.c s_stop.c s_paus.c system_.c cabs.c ctype.c derf_.c
    derfc_.c erf_.c erfc_.c sig_die.c uninit.c)
set(POW pow_ci.c pow_dd.c pow_di.c pow_hh.c pow_ii.c pow_ri.c pow_zi.c pow_zz.c)
set(CX c_abs.c c_cos.c c_div.c c_exp.c c_log.c c_sin.c c_sqrt.c)
set(DCX z_abs.c z_cos.c z_div.c z_exp.c z_log.c z_sin.c z_sqrt.c)
set(REAL r_abs.c r_acos.c r_asin.c r_atan.c r_atn2.c r_cnjg.c r_cos.c r_cosh.c r_dim.c
    r_exp.c r_imag.c r_int.c r_lg10.c r_log.c r_mod.c r_nint.c r_sign.c r_sin.c
    r_sinh.c r_sqrt.c r_tan.c r_tanh.c)
set(DBL d_abs.c d_acos.c d_asin.c d_atan.c d_atn2.c d_cnjg.c d_cos.c d_cosh.c d_dim.c
    d_exp.c d_imag.c d_int.c d_lg10.c d_log.c d_mod.c d_nint.c d_prod.c d_sign.c
    d_sin.c d_sinh.c d_sqrt.c d_tan.c d_tanh.c)
set(INT i_abs.c i_dim.c i_dnnt.c i_indx.c i_len.c i_mod.c i_nint.c i_sign.c lbitbits.c
    lbitshft.c)
set(HALF h_abs.c h_dim.c h_dnnt.c h_indx.c h_len.c h_mod.c h_nint.c h_sign.c)
set(CMP l_ge.c l_gt.c l_le.c l_lt.c hl_ge.c hl_gt.c hl_le.c hl_lt.c)
set(EFL ef1asc_.c ef1cmc_.c)
set(CHAR f77_aloc.c s_cat.c s_cmp.c s_copy.c)
set(I77 backspac.c close.c dfe.c dolio.c due.c endfile.c err.c fmt.c fmtlib.c ftell_.c
    iio.c ilnw.c inquire.c lread.c lwrite.c open.c rdfmt.c rewind.c rsfe.c rsli.c
    rsne.c sfe.c sue.c typesize.c uio.c util.c wref.c wrtfmt.c wsfe.c wsle.c wsne.c
    xwsne.c)
set(QINT pow_qq.c qbitbits.c qbitshft.c ftell64_.c)
set(TIME dtime_.c etime_.c)
set(OFILES ${MISC} ${POW} ${CX} ${DCX} ${REAL} ${DBL} ${INT} ${HALF} ${CMP} ${EFL}
  ${CHAR} ${I77} ${QINT} ${TIME})
list(TRANSFORM OFILES PREPEND "${f2c_src_SOURCE_DIR}/")

#### Shared and static library generation
add_library(f2cobjs OBJECT ${OFILES})
target_compile_definitions(f2cobjs PUBLIC Skip_f2c_Undefs INTEGER_STAR_8)

add_library(f2c_static STATIC $<TARGET_OBJECTS:f2cobjs>)
set_target_properties(f2c_static PROPERTIES OUTPUT_NAME f2c POSITION_INDEPENDENT_CODE 1)
target_include_directories (f2c_static INTERFACE
  $<BUILD_INTERFACE:${f2c_src_SOURCE_DIR}>
  $<INSTALL_INTERFACE:>)

target_compile_definitions(f2c_static INTERFACE Skip_f2c_Undefs INTEGER_STAR_8)
add_library(f2c::f2c ALIAS f2c_static)
