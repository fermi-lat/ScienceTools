file(REMOVE_RECURSE
  "libhealpix_cxx.a"
  "libhealpix_cxx.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang C CXX)
  include(CMakeFiles/healpix_cxx.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
