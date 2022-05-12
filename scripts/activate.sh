#!/bin/bash
# source this file to augment your working environment, populating environment variables

if [ ! $# -eq 1 ]; then
  echo -e "No Build Directory provided on command line. Defaulting to 'Release'."
fi

BUILD_DIR=${1:-"Release"}

if [ ! -d ${BUILD_DIR} ]; then
  echo -e "Build Directory not found: '${BUILD_DIR}'. Exiting."
  return 1
fi

INSTALL_PREFIX=$(grep "^CMAKE_INSTALL_PREFIX:PATH=" ${BUILD_DIR}/CMakeCache.txt | cut -d "=" -f 2)

echo -e "Parsed INSTALL_PREFIX: $INSTALL_PREFIX"

# This instructs the Fermi ST where to find their data

INST_DIR=$INSTALL_PREFIX/share/fermitools
FERMI_DIR=$INST_DIR
FERMI_INST_DIR=$INST_DIR
BASE_DIR=$INST_DIR
EXTFILESSYS=$CONDA_PREFIX/share/fermitools/refdata/fermi
GENERICSOURCESDATAPATH=$CONDA_PREFIX/share/fermitools/data/genericSources
TIMING_DIR=$CONDA_PREFIX/share/fermitools/refdata/fermi/jplephem

# Set necessary CALDB variables 
CALDBALIAS=$FERMI_DIR/data/caldb/software/tools/alias_config.fits
CALDBCONFIG=$FERMI_DIR/data/caldb/software/tools/caldb.config
CALDBROOT=$FERMI_DIR/data/caldb
CALDB=$FERMI_DIR/data/caldb


# The new path to check or add
NEW_FERMI_PATH=$CONDA_PREFIX/bin/fermitools

# Check that the new path is not already a member of the $PATH
if [[ ${PATH} != *"${NEW_FERMI_PATH}"* ]]; then
    # Add the new fermi path to the $PATH
    export PATH=${NEW_FERMI_PATH}:${PATH}
fi

# Setup PFILES

if [ -z ${PFILES+x} ]; then
    # PFILES is unset, set it appropriately
    mkdir -p $HOME/pfiles
    export PFILES=".:${HOME}/pfiles;${INST_DIR}/syspfiles"
else
    if [[ ${PFILES} == *[';']* ]]; then
        # current value already contains a ';', which
        # separates read-write pfiles path to read-only
        # pfiles path. Just add the ST one
        export PFILES="${PFILES}:${INST_DIR}/syspfiles"
    else
        # Current value doesn't have any read-only
        # pfiles path. Add the ST one.
        export PFILES="${PFILES};${INST_DIR}/syspfiles"
    fi
fi

# Issue warnings if PYTHONPATH, LD_LIBRARY_PATH, or DYLD_LIBRARY_PATH are set
if [ ! -z ${DYLD_LIBRARY_PATH+x} ]; then
    echo "You have DYLD_LIBRARY_PATH set. This might interfere with the correct functioning of conda and the Fermitools."
fi
if [ ! -z ${LD_LIBRARY_PATH+x} ]; then
    echo "You have LD_LIBRARY_PATH set. This might interfere with the correct functioning of conda and the Fermitools."
fi
if [ ! -z ${PYTHONPATH+x} ]; then
    echo "You have PYTHONPATH set. This might interfere with the correct functioning of conda and the Fermitools."
fi
### This looping construction works in bash, but not zsh.
# for env_var in "DYLD_LIBRARY_PATH" "LD_LIBRARY_PATH" "PYTHONPATH"
# do
#   if [ ! -z ${!env_var+x} ]; then
#       echo "You have ${env_var} set. This might interfere with the correct functioning of conda and the Fermitools"
#   fi
# done
