# -*- mode: sh -*-

export condaname="fermitools"

if [ "$(uname)" == "Darwin" ]; then
    export CXXFLAGS="-std=c++17 ${CXXFLAGS}" 
    export LDFLAGS="${LDFLAGS}  -lstdc++ -headerpad_max_install_names"
    export TOOLCHAIN_FILE="cmake/macos-toolchain.cmake"
    brew install llvm
else
    export TOOLCHAIN_FILE="cmake/linux-toolchain.cmake"
fi

# Install the compiler into the BUILD env only. A bare `conda install` targets
# the active env, which put the GCC toolchain (~450-720 MB installed) into
# $PREFIX and therefore into the shipped package.
echo "Installing conda forge cxx compiler"
conda install --yes --prefix "${BUILD_PREFIX}" conda-forge::cxx-compiler

# Never ship debug info (Debug builds made libLikelihood.so ~79 MB vs ~11 MB).
export CFLAGS="${CFLAGS} -g0"
export CXXFLAGS="${CXXFLAGS} -g0"

if [ "$(uname)" == "Darwin" ]; then
    echo "Configuring for macOS"
    cmake -S . \
        -B Release \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE \
        -DCMAKE_PREFIX_PATH="${PREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        -DPython3_EXECUTABLE="${BUILD_PREFIX}/bin/python3" \
        -DPython3_NumPy_INCLUDE_DIR="${SP_DIR}/numpy/core/include" \
        ${CMAKE_ARGS}
else
    echo "Configuring for Linux $(uname -m)"
	
	if [ "$(uname -m)" == "x86_64" ]; then
		conda install --yes --prefix "${BUILD_PREFIX}" sysroot_linux-64 -c conda-forge
		conda update --yes --prefix "${BUILD_PREFIX}" sysroot_linux-64 -c conda-forge
	else
		echo "Pip install pyregion for Linux messes with cfitsio"
	fi
	
    cmake -S . \
        -B Release \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_C_FLAGS="-fPIC -std=gnu17" -DCMAKE_CXX_FLAGS="-fPIC" \
		-DPython3_EXECUTABLE="$(which python)" \
        -DCMAKE_PREFIX_PATH="${PREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        ${CMAKE_ARGS}

echo "IMAGE INFORMATION"
ldd --version
cat /etc/os-release

fi

cmake --build Release --clean-first --parallel ${CPU_COUNT:-2} --target=install 
#cmake --build Release --clean-first --target=install --verbose
# Copy the activate and deactivate scripts
mkdir -p $PREFIX/etc/conda/activate.d
mkdir -p $PREFIX/etc/conda/deactivate.d

cp recipe/activate.sh $PREFIX/etc/conda/activate.d/activate_${condaname}.sh
cp recipe/deactivate.sh $PREFIX/etc/conda/deactivate.d/deactivate_${condaname}.sh

cp recipe/activate.csh $PREFIX/etc/conda/activate.d/activate_${condaname}.csh
cp recipe/deactivate.csh $PREFIX/etc/conda/deactivate.d/deactivate_${condaname}.csh

# Copy ST-AGN-Thread-Test Data
cp recipe/tests/data/inputs/* $PREFIX/share/${condaname}/data
mkdir -p $PREFIX/share/${condaname}/data/outref
cp recipe/tests/data/outref/* $PREFIX/share/${condaname}/data/outref

# Copy utils helper script directory
mkdir -p $PREFIX/share/${condaname}/utils
cp recipe/utils/* $PREFIX/share/${condaname}/utils

# Delete the cmake build directory
rm -rf Release

# Trim the package: no static libs or headers from the vendored externals
# (nothing downstream builds against fermitools), and strip any debug info that
# slipped through. bin/test_* are kept because the unit tests run them.
rm -f "${PREFIX}"/lib/*.a
rm -rf "${PREFIX}/include"
if [ "$(uname)" == "Darwin" ]; then
    STRIP_FLAGS="-x"
else
    STRIP_FLAGS="--strip-unneeded"
fi
for f in "${PREFIX}"/bin/* "${PREFIX}"/lib/*.so* "${PREFIX}"/lib/*.dylib; do
    if [ -f "$f" ] && [ ! -L "$f" ] && file "$f" | grep -qE 'ELF|Mach-O'; then
        ${STRIP:-strip} ${STRIP_FLAGS} "$f" || true
    fi
done

# Determine which conda env we are in. If it's base than we could "exit" conda.
echo "Conda env $CONDA_PREFIX"

echo "List Conda env"
conda env list --json
# Play it safe
conda deactivate

