OS architecture specific environment files for simply building, or actively developing the Fermi ScienceTools with conda dependencies.

Create a conda development environment by executing:

``` sh
conda env create -n fermi-dev -f environments/fermitools-develop-linux.yml
```

Or as appropriate with your chosen target architecture.

Currently, the only 2 files actively used are : fermitools-develop-osx.yml and fermitools-develop-linux.yml (for ci/cd and local development) 10/25 
