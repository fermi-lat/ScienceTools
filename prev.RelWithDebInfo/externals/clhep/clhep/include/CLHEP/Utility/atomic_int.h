#ifndef CLHEP_ATOMIC_INT_H
#define CLHEP_ATOMIC_INT_H

// ======================================================================
//
// Use std::atomic when the compiler declares it uses the C++11 standard
//
// on macOS, atomic is available starting with Sierra (Darwin 16)
// ======================================================================

#if _WIN32
    #include <atomic>
    #define CLHEP_ATOMIC_INT_TYPE std::atomic<int>
#else
  #if __cplusplus >= 201103L

  #if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ > 7) || __clang__
    #include <atomic>
    #define CLHEP_ATOMIC_INT_TYPE std::atomic<int>
  #else
    #define CLHEP_ATOMIC_INT_TYPE int
  #endif

  #else
    #define CLHEP_ATOMIC_INT_TYPE int
  #endif
#endif

#endif
