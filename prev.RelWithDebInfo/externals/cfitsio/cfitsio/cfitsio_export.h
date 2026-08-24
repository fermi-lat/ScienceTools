
#ifndef CFITSIO_EXPORT_H
#define CFITSIO_EXPORT_H

#ifdef CFITSIO_STATIC_DEFINE
#  define CFITSIO_EXPORT
#  define CFITSIO_NO_EXPORT
#else
#  ifndef CFITSIO_EXPORT
#    ifdef cfitsio_EXPORTS
        /* We are building this library */
#      define CFITSIO_EXPORT 
#    else
        /* We are using this library */
#      define CFITSIO_EXPORT 
#    endif
#  endif

#  ifndef CFITSIO_NO_EXPORT
#    define CFITSIO_NO_EXPORT 
#  endif
#endif

#ifndef CFITSIO_DEPRECATED
#  define CFITSIO_DEPRECATED __attribute__ ((__deprecated__))
#endif

#ifndef CFITSIO_DEPRECATED_EXPORT
#  define CFITSIO_DEPRECATED_EXPORT CFITSIO_EXPORT CFITSIO_DEPRECATED
#endif

#ifndef CFITSIO_DEPRECATED_NO_EXPORT
#  define CFITSIO_DEPRECATED_NO_EXPORT CFITSIO_NO_EXPORT CFITSIO_DEPRECATED
#endif

/* NOLINTNEXTLINE(readability-avoid-unconditional-preprocessor-if) */
#if 0 /* DEFINE_NO_DEPRECATED */
#  ifndef CFITSIO_NO_DEPRECATED
#    define CFITSIO_NO_DEPRECATED
#  endif
#endif

#endif /* CFITSIO_EXPORT_H */
