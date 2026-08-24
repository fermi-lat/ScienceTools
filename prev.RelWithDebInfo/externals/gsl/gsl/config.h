#ifndef GSL_CONFIG_H
#define GSL_CONFIG_H

/* Generated from CMake configuration */

/* Disable deprecated functions and enums while building */
/* #undef GSL_DISABLE_DEPRECATED */

/* Define if you have inline with C99 behavior */
#define HAVE_C99_INLINE 1

/* Define if the <complex.h> header is available */
#define HAVE_COMPLEX_H 1

/* Example: check for individual declarations */
#define HAVE_DECL_ACOSH 1
#define HAVE_DECL_ASINH 1
#define HAVE_DECL_ATANH 1
#define HAVE_DECL_EXPM1 1
/* #undef HAVE_DECL_FEENABLEEXCEPT */
/* #undef HAVE_DECL_FESETTRAPENABLE */
/* #undef HAVE_DECL_FINITE */
/* #undef HAVE_DECL_FPRND_T */
#define HAVE_DECL_FREXP 1
#define HAVE_DECL_HYPOT 1
#define HAVE_DECL_ISFINITE 1
#define HAVE_DECL_ISINF 1
#define HAVE_DECL_ISNAN 1
#define HAVE_DECL_LDEXP 1
#define HAVE_DECL_LOG1P 1

#define HAVE_DLFCN_H
/* #undef HAVE_DOPRNT */
/* #undef HAVE_EXIT_SUCCESS_AND_FAILURE */
/* #undef HAVE_EXTENDED_PRECISION_REGISTERS */
/* #undef HAVE_FPU_X86_SSE */
/* #undef HAVE_IEEEFP_H */
/* #undef HAVE_IEEE_COMPARISONS */
/* #undef HAVE_IEEE_DENORMALS */
/* #undef HAVE_INLINE */
#define HAVE_INTTYPES_H
#define HAVE_LIBM
#define HAVE_MEMCPY
#define HAVE_MEMMOVE
/* #undef HAVE_PRINTF_LONGDOUBLE */
#define HAVE_STDINT_H
/* #undef HAVE_STDIO_H */
#define HAVE_STDLIB_H
#define HAVE_STRDUP
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_STRTOL
#define HAVE_STRTOUL
#define HAVE_SYS_STAT_H
#define HAVE_SYS_TYPES_H
#define HAVE_UNISTD_H
#define HAVE_VPRINTF
/* #undef HIDE_INLINE_STATIC */

/* #undef LT_OBJDIR */

/* #undef PACKAGE */
/* #undef PACKAGE_BUGREPORT */
/* #undef PACKAGE_NAME */
/* #undef PACKAGE_STRING */
/* #undef PACKAGE_TARNAME */
/* #undef PACKAGE_URL */
/* #undef PACKAGE_VERSION */
/* #undef RELEASED */
/* #undef STDC_HEADERS */
/* #undef VERSION */

/* Architecture-specific IEEE support macros */
/* #undef HAVE_GNUSPARC_IEEE_INTERFACE */
/* #undef HAVE_GNUM68K_IEEE_INTERFACE */
/* #undef HAVE_GNUPPC_IEEE_INTERFACE */
/* #undef HAVE_GNUX86_IEEE_INTERFACE */
/* #undef HAVE_SUNOS4_IEEE_INTERFACE */
/* #undef HAVE_SOLARIS_IEEE_INTERFACE */
/* #undef HAVE_HPUX11_IEEE_INTERFACE */
/* #undef HAVE_HPUX_IEEE_INTERFACE */
/* #undef HAVE_TRU64_IEEE_INTERFACE */
/* #undef HAVE_IRIX_IEEE_INTERFACE */
/* #undef HAVE_AIX_IEEE_INTERFACE */
/* #undef HAVE_FREEBSD_IEEE_INTERFACE */
/* #undef HAVE_OS2EMX_IEEE_INTERFACE */
/* #undef HAVE_NETBSD_IEEE_INTERFACE */
/* #undef HAVE_OPENBSD_IEEE_INTERFACE */
/* #undef HAVE_DARWIN_IEEE_INTERFACE */
/* #undef HAVE_DARWIN86_IEEE_INTERFACE */

/* Define to '__inline__' or '__inline' if that's what the C compiler calls it */
#ifndef __cplusplus
/* #undef inline */
#endif

/* Define as 'unsigned int' if <stddef.h> doesn't define. */
/* #undef size_t */

/* Define to empty if the keyword 'volatile' does not work. */
/* #undef volatile */

#if !HAVE_EXIT_SUCCESS_AND_FAILURE
#define EXIT_SUCCESS 0
#define EXIT_FAILURE 1
#endif

#if HAVE_EXTENDED_PRECISION_REGISTERS
#define GSL_COERCE_DBL(x) (gsl_coerce_double(x))
#else
#define GSL_COERCE_DBL(x) (x)
#endif

#if !HAVE_DECL_HYPOT
#define hypot gsl_hypot
#endif
#if !HAVE_DECL_LOG1P
#define log1p gsl_log1p
#endif
#if !HAVE_DECL_EXPM1
#define expm1 gsl_expm1
#endif
#if !HAVE_DECL_ACOSH
#define acosh gsl_acosh
#endif
#if !HAVE_DECL_ASINH
#define asinh gsl_asinh
#endif
#if !HAVE_DECL_ATANH
#define atanh gsl_atanh
#endif
#if !HAVE_DECL_LDEXP
#define ldexp gsl_ldexp
#endif
#if !HAVE_DECL_FREXP
#define frexp gsl_frexp
#endif
#if !HAVE_DECL_ISINF
#define isinf gsl_isinf
#endif
#if !HAVE_DECL_ISFINITE
#define isfinite gsl_finite
#endif
#if !HAVE_DECL_FINITE
#define finite gsl_finite
#endif
#if !HAVE_DECL_ISNAN
#define isnan gsl_isnan
#endif

#ifdef __GNUC__
#define DISCARD_POINTER(p) do { ; } while(p ? 0 : 0)
#else
#define DISCARD_POINTER(p) /* ignoring discarded pointer */
#endif

#if defined(GSL_RANGE_CHECK_OFF) || !defined(GSL_RANGE_CHECK)
#define GSL_RANGE_CHECK 0
#endif

#define RETURN_IF_NULL(x) if (!(x)) { return; }

#endif /* GSL_CONFIG_H */
