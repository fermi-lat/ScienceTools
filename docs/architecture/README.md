# Fermitools Architecture

The Fermitools (ScienceTools) are the analysis software for data from the
Fermi Large Area Telescope (LAT). This repository is an **umbrella**: it holds
the CMake build, the conda packaging and CI. Each component package is a
separate git repository under `fermi-lat/`, included as a submodule in
`src/` (component packages) or `externals/` (third-party libraries).

This directory holds documentation that covers the system as a whole.
Package-level documentation lives in each package at
`src/<pkg>/doc/architecture/README.md`. See
[documentation-structure.md](documentation-structure.md) for how the
documentation is organized.

| Document | Read it when you need to… |
|----------|---------------------------|
| This file | get oriented, or find the package that owns something |
| [dependency-layers.md](dependency-layers.md) | understand who depends on whom, where new code belongs, or what a change affects |
| `build-and-release.md` *(planned)* | build, package or release the tools, or move a submodule pin |
| `externals.md` *(planned)* | change how a third-party library is built or found |
| [documentation-structure.md](documentation-structure.md) | write or update architecture docs |

## System overview

The packages fall into five tiers. Each tier may depend only on the tiers
below it. Full details are in [dependency-layers.md](dependency-layers.md).

```
 python       pyLikelihood · pyExposure · sane · modelEditor · pyBurstAnalysisGUI
 analysis     Likelihood · evtbin · dataSubselector · map_tools · rspgen · observationSim · …
 instrument   irfs · flux · celestialSources · catalogAccess
 io           tip · astro · healpix · st_facilities
 foundation   facilities · st_stream · ape · hoops · st_app · st_graph · xmlBase · embed_python · Minuit2
 externals    cfitsio · CLHEP · GSL · FFTW · f2c · healpix_cxx · WCSlib · CppUnit · Python/SWIG
```

### How a `gt*` tool runs

Almost every command-line tool follows the same pattern:

```
gtfoo  (executable built by the owning package, e.g. Likelihood/src/gtfoo)
  └─ st_app      common main(): StApp subclass created through an app factory
       ├─ hoops / ape   read and prompt for parameters from gtfoo.par (installed to syspfiles/)
       └─ st_stream     controlled terminal output (chatter levels)
  └─ package library      the science (e.g. Likelihood, evtbin, dataSubselector)
       ├─ irfs          instrument response functions, loaded from CALDB
       ├─ astro/healpix sky directions, coordinate transforms, pixelization
       └─ tip           all FITS reading and writing (FT1 events, FT2 spacecraft, maps, cubes)
```

Python users reach the same libraries through SWIG bindings (`pyLikelihood`,
`pyIrfLoader`, `pyExposure`, `py_facilities`) or through `sane`'s `gt_apps`
wrappers, which run the executables with par-file handling.

### Main data products

- **FT1** (event lists) and **FT2** (spacecraft pointing and livetime).
  These are the inputs to most tools. They are read through `tip` and
  filtered by `dataSubselector`, which also maintains the DSS keywords that
  record the cuts applied.
- **Counts maps and cubes, livetime cubes, exposure maps, source maps.**
  These are intermediate products, written mainly by `evtbin` and
  `Likelihood`.
- **XML source models.** Spectral and spatial models used by `Likelihood`
  and `observationSim`, parsed through `xmlBase`. `modelEditor` edits them.
- **IRFs** come from CALDB and are loaded by `irfs` (`irfLoader`).

## Package index

The *Docs* column shows whether the package has architecture documentation
at `src/<pkg>/doc/architecture/README.md`. Paths are relative to the
ScienceTools root. Links between submodules don't resolve on GitHub, so open
them from a local checkout.

### Tier 0: foundation

| Package | Purpose | Tools | Docs |
|---------|---------|-------|------|
| `facilities` | Low-level utilities: environment and path setup (`commonUtilities`), data-path lookup, misc static helpers. Python binding `py_facilities`. | — | — |
| `st_stream` | Output streams with chatter-level control, used for all tool output. | — | — |
| `ape` | HEASARC parameter-file library (PIL-compatible C library), plus the `p*` parameter utilities. | `pget`, `pset`, `plist`, `pquery`, `punlearn`, `pcheck` | — |
| `hoops` | C++ object-oriented interface to parameter files, built on `ape`. | — | — |
| `st_app` | Application framework: common `main`, `StApp` base class, app factory, parameter handling. | — | — |
| `st_graph` | Simple plotting interface with a matplotlib engine (through `embed_python`). | — | — |
| `xmlBase` | XML parsing and writing (rapidxml-based) and the `IFile` configuration reader. | — | — |
| `embed_python` | Helper for embedding a Python interpreter in C++ (`embed_python::Module`). | — | — |
| `Minuit2` | Vendored standalone Minuit2 minimizer from ROOT (built as `FermiMinuit2`). Upstream docs apply. | — | — |

### Tier 1: io

| Package | Purpose | Tools | Docs |
|---------|---------|-------|------|
| `tip` | Format-independent, iterator-based API for FITS tables, images and headers, built on cfitsio. | — | ✅ `src/tip/doc/architecture/` *(draft on `tip` branch `doc-updates`)* |
| `astro` | Astronomy primitives: `SkyDir`, `JulianDate`, Earth orbit and coordinates, sky projections (WCSlib), HEALPix helpers. | — | — |
| `healpix` | Fermi C++ wrappers around HEALPix: pixel containers, `HealpixArray`, spherical harmonics. | — | — |
| `st_facilities` | Shared utilities for the Science Tools: FITS image and table helpers, environment, numerical integration (`GaussianQuadrature`, `dgaus8`), root finding, bilinear interpolation, timers. | — | — |

### Tier 2: instrument

| Package | Purpose | Tools | Docs |
|---------|---------|-------|------|
| `irfs` | Instrument response functions: abstract interface (`irfInterface`), CALDB loader (`irfLoader`), utilities (`irfUtil`), LAT response implementations. Python binding `pyIrfLoader`. | `gtirfs` | — |
| `flux` | Framework for defining sources and generating photons from them, with XML-driven source definitions. | — | — |
| `celestialSources` | Astrophysical source models for simulation: GRBs, pulsars, microquasars, generic sources, EBL attenuation (`eblAtten`). | — | — |
| `catalogAccess` | Reading and querying astronomical source catalogs. | — | — |

### Tier 3: analysis

| Package | Purpose | Tools | Docs |
|---------|---------|-------|------|
| `optimizers` | Function and parameter abstractions and minimizers (`Minuit`, `NewMinuit` (Minuit2), `Drmngb`/`Drmnfb`, `Lbfgs`, `Amoeba`, `Powell`, `Mcmc`, …) used by model fitting. | — | — |
| `evtbin` | Binning events into histograms: light curves, spectra (PHA), counts maps and cubes, HEALPix maps. | `gtbin`, `gtbindef` | — |
| `dataSubselector` | Event selection and DSS keyword management; Good Time Interval computation. | `gtselect`, `gtmktime`, `gtvcut` | — |
| `timeSystem` | Time systems (TT, TAI, UTC, TDB) and conversions; barycentric correction. | `gtbary` | — |
| `orbitSim` | Spacecraft orbit and attitude simulation (FT2 generation). | `gtorbsim` | — |
| `fitsGen` | Library for building FT1/FT2-format FITS files (used by `observationSim`). | — | — |
| `map_tools` | Count and exposure map utilities. | `gtdispcube`, `exposure_cube` | — |
| `burstFit` | Burst light-curve analysis: Bayesian Blocks segmentation of the profile, then pulse-shape fitting. | `gtburstfit` | — |
| `sourceIdentify` | Source identification by cross-correlating LAT sources with counterpart catalogs. | `gtsrcid` | — |
| `rspgen` | Generating detector response matrices (RSP) for spectral analysis. | `gtrspgen` | — |
| `observationSim` | Simulating LAT observations: sources from `flux`/`celestialSources` passed through `irfs`. | `gtobssim` | — |
| `Likelihood` | Binned and unbinned maximum-likelihood source analysis, plus the exposure, livetime, source-map and TS-map machinery behind it. | `gtlike`, `gtltcube`, `gtltsum`, `gtexpmap`, `gtexpcube2`, `gtsrcmaps`, `gtmodel`, `gtdiffrsp`, `gtpsf`, `gtdrm`, `gtsrcprob`, `gtfindsrc`, `gttsmap`, `gttscube`, `gthealcube`, `gtwtsmap`, `gtbkg`, `gteffbkg`, `gtalphabkg`, `gtebl` | — |
| `BayesianBlocks` | Bayesian Blocks segmentation (Scargle et al.) for event and binned data, with a Python interface. | — | — |
| `SolarSystemTools` | Exposure and template tools for moving solar-system sources (primarily the Sun). | `gtltcubesun`, `gtltsumsun`, `gtexpcubesun`, `gtexphpsun`, `gtsuntemp` | — |

### Tier 4: python

| Package | Purpose | Tools | Docs |
|---------|---------|-------|------|
| `pyLikelihood` | SWIG bindings for `Likelihood` plus the Python analysis layer (`UnbinnedAnalysis`, `BinnedAnalysis`, `SummedLikelihood`, upper limits, SED). | — | — |
| `pyExposure` | Time-binned LAT exposure (effective area integrated over time bins), with Python light-curve helpers. | `gtexposure` | — |
| `sane` | `gt_apps`/`GtApp` Python wrappers for running the tools, source-model helpers, and an end-to-end integration test (`test_sane`). | — | — |
| `modelEditor` | Tkinter GUI for editing XML source models. | `modeleditor` | — |
| `pyBurstAnalysisGUI` | gtBurst, a GUI and scripts for GRB and solar-flare analysis. | `gtburst` | — |

### Support

| Package | Purpose | Docs |
|---------|---------|------|
| `fermitools-fhelp` | `fhelp` help text for each tool. Changes to tool help belong here. | — |

### Not built

`skymaps` is a submodule in `src/`, but it is not part of the CMake build
(see [dependency-layers.md](dependency-layers.md#not-built)).

## Where to put things

- **A new `gt*` tool:** in the package that owns its science, using
  `st_app` for `main` and a par file in that package's `pfiles/`. Help text
  goes in `fermitools-fhelp`.
- **FITS reading or writing:** go through `tip`. If several packages need
  the same helper, put it in `st_facilities`.
- **Generic utilities with no astronomy content:** `facilities`. If the
  utility is astronomy-aware, use `astro` or `st_facilities`.
- **Anything that would make a lower tier depend on a higher one:** don't.
  Restructure the change instead, and see
  [dependency-layers.md](dependency-layers.md).
