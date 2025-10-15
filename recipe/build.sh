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

echo "Installing conda forge cxx compiler"
conda install --yes conda-forge::cxx-compiler

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
    echo "Configuring for Linux"
    cmake -S . \
        -B Release \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_C_FLAGS="-fPIC" -DCMAKE_CXX_FLAGS="-fPIC" \
		-DPython3_EXECUTABLE="$(which python)" \
        -DCMAKE_PREFIX_PATH="${PREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        ${CMAKE_ARGS}
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

# Delete the cmake build directory
rm -rf Release 

# Determine which conda env we are in. If it's base than we could "exit" conda.
echo "Conda env $CONDA_PREFIX"

echo "List Conda env"
conda env list --json
# Play it safe
conda deactivate


