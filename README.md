# Fermi ScienceTools

This meta-package of the user-facing Fermi ScienceTools employs git submodules to link
to component packages. A git submodule is another git repository which is linked to by
this repo.

To also fetch these submodules on clone run:
`git clone --recurse-submodules https://github.com/fermi-lat/ScienceTools.git`

If you have cloned the top level repo already you can also grab all the repositories with:
`git submodule update --init .`


## Developer's Note

To run a branch and some parallel clone jobs run something like:
`git clone -b cmake-update --recurse-submodules -j8 git@github.com:fermi-lat/ScienceTools.git`

The metadata for the included submodules is found in the top level `.gitmodules` file.

The operate on all the submodules as a group, use the `git submodule foreach` command.

### Examples:

 1. Checkout a branch or recover from a detached head: `git submodule foreach 'git checkout cmake-update ||:'`
 1. Add a commit: `git submodule foreach 'git checkout cmake-update ||:'`
 1. Switch to ssh protocol: `git submodule foreach 'git remote -v set-url origin git@github.com:fermi-lat/$(basename $(pwd)).git ||:'`
 1. Submodule update alias `git config alias.supdate 'submodule update --remote --merge'`
 1. Submodule Push alias `git config alias.spush 'push --recurse-submodules=on-demand'`


