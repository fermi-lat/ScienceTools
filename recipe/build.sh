# -*- mode: sh -*-

export condaname="fermitools"

echo "MACOS_ARCH - Build.sh: $MACOS_ARCH"

if [ "$(uname)" == "Darwin" ]; then
    # If Mac OSX then set sysroot flag (see conda_build_config.yaml)
    #export CXXFLAGS="-mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET} -std=c++17 ${CXXFLAGS}" 
    export CXXFLAGS="-std=c++17 ${CXXFLAGS}" 
    export LDFLAGS="${LDFLAGS}  -lstdc++ -headerpad_max_install_names"
    export TOOLCHAIN_FILE="cmake/toolchain-homebrew-llvm.cmake"
    brew install llvm
else
    export TOOLCHAIN_FILE="cmake/cross-linux.cmake"
fi

######
echo "PYTHONPATH: "
echo $PYTHONPATH
echo "which python: "
which python
echo "python version: "
python --version
echo "PREFIX: "
echo $PREFIX

######
#echo "Install conda-forge cxx compiler directly:"
#if [ "$(uname)" != "Darwin"]; then
echo "Installing conda forge cxx compiler"
conda install --yes conda-forge::cxx-compiler
#fi

git submodule foreach 'git checkout vendor_externals ||:'
git submodule foreach 'git pull origin vendor_externals ||:'

if [ "$(uname)" == "Darwin" ]; then
    echo "Configuring for macOS"
    cmake -S . \
        -B RelWithDebInfo \
        -DCMAKE_BUILD_TYPE=Debug \
        -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE \
        -DCMAKE_PREFIX_PATH="${PREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        -DPython3_EXECUTABLE="${BUILD_PREFIX}/bin/python3" \
        -DPython3_NumPy_INCLUDE_DIR="${SP_DIR}/numpy/core/include" \
        ${CMAKE_ARGS}
else
    echo "Configuring for Linux"
    cmake -S . \
        -B RelWithDebInfo \
        -DCMAKE_C_COMPILER="$(which gcc)" \
        -DCMAKE_BUILD_TYPE=Debug \
        -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE \
        -DCMAKE_PREFIX_PATH="${PREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        ${CMAKE_ARGS}
fi

#cmake --build Release --clean-first --parallel ${CPU_COUNT:-2} --target=install 
cmake --build RelWithDebInfo --clean-first --target=install --verbose
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
# activate.sh:export INST_DIR=$CONDA_PREFIX/share/${condaname}
echo "List Conda env"
conda env list --json
# Play it safe
conda deactivate
# Don't do any conda clean here
# conda clean -ap
