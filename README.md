# Fermi ScienceTools

This meta-package of the user-facing Fermi ScienceTools employs git submodules to link
to component packages. A git submodule is another git repository which is linked to by
this repo.

To also fetch these submodules on clone run:
`git clone --recurse-submodules https://github.com/fermi-lat/ScienceTools.git`

If you have cloned the top level repo already you can also grab all the repositories with:
`git submodule update --init .`

## Building the tools

The Fermitools has moved to using CMAKE for its build system. When paired with conda for
dependency package management this provides robust and well-supported system for
cross-compliling the tools on differing host and target systems.

### Requirements

With a fully set up conda environment you can install the needed build-time dependencies
from the provided conda environment file in `environments/fermitools-build.yml`

```bash
conda env create -n fermi-build -f environments/fermitools-build.yml
conda activate fermi-build
```

For all the runtime and test-time dependencies we have also provided the
`fermitools-build-run-test.yml` environment.

<details>
<summary> Generating an environment file. </summary>
A new environment file candidate can be created from the command line. I say candidate
because the YAML needs to me modified to actually be installable. You need to remove
the 'prefix:' seciton and probably add a '-fermi' to the channel list.

``` bash
conda env export -n fermi-build --from-history >  environments/fermitools-build.yml
```
</details>

### CMake Builds

The build process is split into two steps. **Generation** is similar to a `configure` step;
The host system is polled for needed attributes, programs, and libraries and a Makefile
system is created. The **Build** stage then executes the generated Makefile system to
compile all the Fermitools targets.

Assuming your dependencies are installed and system compilers are all in the local
`$PATH` you can generate a build system by executing the following command from within
the ScienceTools directory:

```bash
cmake -S . \
-B RelWithDebInfo \
-DCMAKE_BUILD_TYPE=RelWithDebInfo \
-DCMAKE_INSTALL_PREFIX="</install/destination/path>" \
-DCMAKE_PREFIX_PATH="</dependency/search/path/>"
```

If your `CMAKE_INSTALL_PREFIX` is the location of your dependencies you can optionally
exclude `CMAKE_PREFIX_PATH`.

This locates needed dependencies and prepares a release build with debug symbols
in the 'RelWithDebInfo' directory. To compile the system now run:

```bash
cmake --build RelWithDebInfo --parallel
```

Optionally you can install the tools in your `CMAKE_INSTALL_PREFIX` with

```bash
cmake --build RelWithDebInfo --parallel --target=install
```

### Conda Builds

The sibling repository for this package is https://github.com/fermi-lat/Fermitools-conda

Once checked out it can be used to trigger a conda build with `conda build `

## Tips for Git Submodules

To run a branch and some parallel clone jobs run something like:
`git clone -b branchname --recurse-submodules -j8 git@github.com:fermi-lat/ScienceTools.git`

The metadata for the included submodules is found in the top level `.gitmodules` file.

The operate on all the submodules as a group, use the `git submodule foreach` command.

### Examples:

1.  Checkout a branch or recover from a detached head: `git submodule foreach 'git checkout branchname ||:'`
1.  Add a commit: `git submodule foreach 'git checkout branchname ||:'`
1.  Switch to ssh protocol: `git submodule foreach 'git remote -v set-url origin git@github.com:fermi-lat/$(basename $(pwd)).git ||:'`
1.  Submodule update alias `git config alias.supdate 'submodule update --remote --merge'`
1.  Submodule Push alias `git config alias.spush 'push --recurse-submodules=on-demand'`
