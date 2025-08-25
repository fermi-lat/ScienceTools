# toolchain-clang-libcxx.cmake

set(BREW_PATH "/opt/homebrew")

# Explicitly set x86_64 architecture for macOS
set(MACOS_ARCH $ENV{MACOS_ARCH})
if(MACOS_ARCH STREQUAL "x86")
  message("Applying x86 compiler settings...")
  set(CMAKE_OSX_ARCHITECTURES "x86_64" CACHE INTERNAL "" FORCE)
  set(BREW_PATH "/usr/local")
endif()

# Explicitly set the compiler paths
set(CMAKE_C_COMPILER "${BREW_PATH}/opt/llvm/bin/clang" CACHE FILEPATH "C compiler")
set(CMAKE_CXX_COMPILER "${BREW_PATH}/opt/llvm/bin/clang++" CACHE FILEPATH "C++ compiler")

# Use the macOS SDK path explicitly (instead of relying on $SDKROOT)
#execute_process(
#  COMMAND xcrun --sdk macosx --show-sdk-path
#  OUTPUT_VARIABLE CMAKE_OSX_SYSROOT
#  OUTPUT_STRIP_TRAILING_WHITESPACE
#)
set(CMAKE_SYSROOT "${CMAKE_OSX_SYSROOT}" CACHE PATH "macOS SDK path")

# Explicitly use libc++ headers and ensure they take precedence
set(CMAKE_CXX_FLAGS_INIT "-isystem ${BREW_PATH}/opt/llvm/include/c++/v1" CACHE STRING "")

# # Also ensure the linker uses the correct libc++ runtime
# set(CMAKE_EXE_LINKER_FLAGS_INIT "-L${BREW_PATH}/opt/llvm/lib -lc++ -lc++abi" CACHE STRING "")

# Invoke with
# cmake -S . -B DebugBrewLLVM -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=toolchain-homebrew-llvm.cmake -DPython3_EXECUTABLE=$(which python)

# Hopefully Equivalent (near equivalent) command line call
# cmake -S . -B Debug -DCMAKE_BUILD_TYPE=Debug -DPython3_EXECUTABLE=$(which python) -DCMAKE_C_COMPILER=$(brew --prefix llvm)/bin/clang -DCMAKE_CXX_COMPILER=$(brew --prefix llvm)/bin/clang++ -DCMAKE_PREFIX_PATH="$(brew --prefix libomp);$(brew --prefix llvm)" -DCMAKE_OSX_SYSROOT="$(xcrun --sdk macosx --show-sdk-path)" -DCMAKE_CXX_FLAGS="-stdlib=libc++ -isystem $(brew --prefix llvm)/include/c++/v1" -DCMAKE_COLOR_DIAGNOSTICS=ON -G Ninja
