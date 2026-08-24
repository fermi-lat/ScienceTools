file(REMOVE_RECURSE
  "libf2c.a"
  "libf2c.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang C)
  include(CMakeFiles/f2c_static.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
