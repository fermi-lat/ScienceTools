# Package Dependency Layers

This document describes how the Fermitools packages depend on each other
and on third-party libraries. Use it to find out what a change might affect
(see `used_by`), to choose where new code belongs, and to avoid creating
dependency cycles.

The dependency data comes from the `target_link_libraries` entries in each
package's `CMakeLists.txt`, excluding tests. Libraries built inside a package
are attributed to that package: `irfInterface`, `irfLoader`, `irfUtil` and
the `*Response` libraries belong to `irfs`; `eblAtten`, `genericSources`,
`microQuasar` and `EarthPhenom` to `celestialSources`; `dgaus8` to
`st_facilities`; `FermiMinuit2` to `Minuit2`. Header-only use does not
appear in this data. When precision matters, check the package's own
architecture doc, where `used_by` is based on actual `#include` usage.

*Generated against ScienceTools commit `9f7097e4` with all submodules at the
heads of their default branches.*

## Tiers

Each package belongs to one tier. A package may depend only on packages in
its own tier or in lower tiers. These tier names are the allowed values of
the `layer:` front-matter field in package architecture docs.

| Tier | `layer:` | Role | Packages |
|------|----------|------|----------|
| 0 | `foundation` | Generic infrastructure with no astronomy knowledge: environment and paths, parameter files, output streams, the application framework, XML, embedded Python, plotting, minimization engine | `facilities`, `st_stream`, `ape`, `hoops`, `embed_python`, `xmlBase`, `Minuit2`, `st_graph`, `st_app` |
| 1 | `io` | FITS I/O and astronomy primitives: tables and images, sky directions and coordinates, HEALPix, shared numerical and FITS utilities | `tip`, `astro`, `healpix`, `st_facilities` |
| 2 | `instrument` | Models of the LAT and the sky: instrument response functions, source and flux models, catalog access | `irfs`, `flux`, `celestialSources`, `catalogAccess` |
| 3 | `analysis` | Science algorithms and the `gt*` tools built on them | `optimizers`, `evtbin`, `dataSubselector`, `timeSystem`, `orbitSim`, `fitsGen`, `map_tools`, `burstFit`, `sourceIdentify`, `rspgen`, `observationSim`, `Likelihood`, `BayesianBlocks`, `SolarSystemTools` |
| 4 | `python` | Python bindings, scripting front ends and GUIs | `pyLikelihood`, `pyExposure`, `sane`, `modelEditor`, `pyBurstAnalysisGUI` |
| — | `support` | Non-code content shipped with the tools | `fermitools-fhelp` |

`optimizers` is a general-purpose library, but it sits in tier 3 because it
depends on `st_facilities` (tier 1). `timeSystem` and `orbitSim` are mostly
libraries, but they also ship tools (`gtbary`, `gtorbsim`).

### Allowed dependency directions

```mermaid
flowchart BT
  T0["Tier 0 · foundation<br/>facilities · st_stream · ape · hoops · embed_python<br/>xmlBase · Minuit2 · st_graph · st_app"]
  T1["Tier 1 · io<br/>tip · astro · healpix · st_facilities"]
  T2["Tier 2 · instrument<br/>irfs · flux · celestialSources · catalogAccess"]
  T3["Tier 3 · analysis<br/>Likelihood · evtbin · dataSubselector · map_tools · rspgen · …"]
  T4["Tier 4 · python<br/>pyLikelihood · pyExposure · sane · modelEditor · pyBurstAnalysisGUI"]
  T1 --> T0
  T2 --> T1
  T2 --> T0
  T3 --> T2
  T3 --> T1
  T3 --> T0
  T4 --> T3
```

### The analysis core

This diagram shows only the edges between tier 2 and tier 3 packages. Edges
to the tier 0 and tier 1 packages are left out because nearly every package
uses `tip`, `astro`, `st_app` and `st_facilities`.

```mermaid
flowchart BT
  irfs; flux; celestialSources; catalogAccess
  optimizers; evtbin; dataSubselector; map_tools; rspgen
  Likelihood; observationSim; fitsGen; burstFit; sourceIdentify
  BayesianBlocks; SolarSystemTools

  celestialSources --> flux
  dataSubselector --> evtbin
  dataSubselector --> irfs
  map_tools --> irfs
  rspgen --> evtbin
  rspgen --> irfs
  rspgen --> dataSubselector
  burstFit --> evtbin
  burstFit --> optimizers
  sourceIdentify --> catalogAccess
  observationSim --> flux
  observationSim --> celestialSources
  observationSim --> irfs
  observationSim --> dataSubselector
  observationSim --> fitsGen
  Likelihood --> irfs
  Likelihood --> celestialSources
  Likelihood --> optimizers
  Likelihood --> evtbin
  Likelihood --> dataSubselector
  Likelihood --> map_tools
  BayesianBlocks --> Likelihood
  BayesianBlocks --> irfs
  SolarSystemTools --> Likelihood
  SolarSystemTools --> evtbin
  SolarSystemTools --> map_tools
  SolarSystemTools --> irfs
```

## Full dependency table

The *Depth* column is the length of the longest dependency chain beneath
the package. It gives a valid build order: lower depths build first.

| Depth | Package | Tier | Depends on (Fermi packages) | Used by |
|------:|---------|------|-----------------------------|---------|
| 0 | `ape` | foundation | — | hoops |
| 0 | `embed_python` | foundation | — | fitsGen, st_graph |
| 0 | `facilities` | foundation | — | SolarSystemTools, astro, celestialSources, dataSubselector, fitsGen, flux, irfs, st_app, tip, xmlBase |
| 0 | `Minuit2` | foundation | — | optimizers |
| 0 | `st_stream` | foundation | — | Likelihood, burstFit, evtbin, irfs, map_tools, observationSim, orbitSim, pyExposure, rspgen, st_app, st_graph, timeSystem |
| 0 | `fermitools-fhelp` | support | — | — |
| 0 | `modelEditor` | python | — (pure Python) | — |
| 0 | `pyBurstAnalysisGUI` | python | — (pure Python; uses the installed tools at runtime) | — |
| 1 | `hoops` | foundation | ape | Likelihood, map_tools, sourceIdentify, st_app, st_graph |
| 1 | `tip` | io | facilities | Likelihood, SolarSystemTools, astro, burstFit, catalogAccess, celestialSources, dataSubselector, evtbin, fitsGen, healpix, irfs, map_tools, observationSim, orbitSim, pyExposure, rspgen, st_facilities, timeSystem |
| 1 | `xmlBase` | foundation | facilities | Likelihood, flux, optimizers, pyExposure |
| 2 | `astro` | io | facilities, tip | BayesianBlocks, Likelihood, SolarSystemTools, celestialSources, dataSubselector, evtbin, fitsGen, flux, healpix, irfs, map_tools, observationSim, pyExposure, rspgen, st_facilities |
| 2 | `st_graph` | foundation | embed_python, hoops, st_stream | Likelihood, burstFit, st_app |
| 3 | `fitsGen` | analysis | astro, embed_python, facilities, tip | observationSim |
| 3 | `flux` | instrument | astro, facilities, xmlBase | celestialSources, observationSim |
| 3 | `healpix` | io | astro, tip | Likelihood, SolarSystemTools, evtbin, map_tools |
| 3 | `st_app` | foundation | facilities, hoops, st_graph, st_stream | Likelihood, SolarSystemTools, burstFit, evtbin, irfs, map_tools, observationSim, orbitSim, pyExposure, rspgen, sane, sourceIdentify, timeSystem |
| 3 | `st_facilities` | io | astro, tip | BayesianBlocks, Likelihood, SolarSystemTools, burstFit, catalogAccess, celestialSources, dataSubselector, evtbin, irfs, optimizers, orbitSim, pyExposure, rspgen, sourceIdentify, timeSystem |
| 4 | `catalogAccess` | instrument | st_facilities, tip | sourceIdentify |
| 4 | `celestialSources` | instrument | astro, facilities, flux, st_facilities, tip | Likelihood, observationSim |
| 4 | `evtbin` | analysis | astro, healpix, st_app, st_facilities, st_stream, tip | Likelihood, SolarSystemTools, burstFit, dataSubselector, rspgen, sane |
| 4 | `irfs` | instrument | astro, facilities, st_app, st_facilities, st_stream, tip | BayesianBlocks, Likelihood, SolarSystemTools, dataSubselector, map_tools, observationSim, pyExposure, pyLikelihood, rspgen |
| 4 | `optimizers` | analysis | Minuit2, st_facilities, xmlBase | Likelihood, burstFit, pyExposure |
| 4 | `orbitSim` | analysis | st_app, st_facilities, st_stream, tip | — |
| 4 | `timeSystem` | analysis | st_app, st_facilities, st_stream, tip | — |
| 5 | `burstFit` | analysis | evtbin, optimizers, st_app, st_facilities, st_graph, st_stream, tip | — |
| 5 | `dataSubselector` | analysis | astro, evtbin, facilities, irfs, st_facilities, tip | Likelihood, observationSim, pyExposure, rspgen, sane |
| 5 | `map_tools` | analysis | astro, healpix, hoops, irfs, st_app, st_stream, tip | Likelihood, SolarSystemTools |
| 5 | `sourceIdentify` | analysis | catalogAccess, hoops, st_app, st_facilities | — |
| 6 | `Likelihood` | analysis | astro, celestialSources, dataSubselector, evtbin, healpix, hoops, irfs, map_tools, optimizers, st_app, st_facilities, st_graph, st_stream, tip, xmlBase | BayesianBlocks, SolarSystemTools, pyExposure, pyLikelihood, sane |
| 6 | `observationSim` | analysis | astro, celestialSources, dataSubselector, fitsGen, flux, irfs, st_app, st_stream, tip | — |
| 6 | `rspgen` | analysis | astro, dataSubselector, evtbin, irfs, st_app, st_facilities, st_stream, tip | sane |
| 7 | `BayesianBlocks` | analysis | Likelihood, astro, irfs, st_facilities | — |
| 7 | `pyExposure` | python | Likelihood, astro, dataSubselector, irfs, optimizers, st_app, st_facilities, st_stream, tip, xmlBase | — |
| 7 | `pyLikelihood` | python | Likelihood, irfs | — |
| 7 | `sane` | python | Likelihood, dataSubselector, evtbin, rspgen, st_app | — |
| 7 | `SolarSystemTools` | analysis | Likelihood, astro, evtbin, facilities, healpix, irfs, map_tools, st_app, st_facilities, tip | — |

## External dependencies

Third-party libraries are either built from `externals/<lib>` or found on
the system. The top-level `CMakeLists.txt` chooses between the two with
`add_or_find(...)` and the `USE_SYSTEM_<LIB>` options. Details of how each
external is integrated will go in `externals.md`.

| External | CMake target | Default source | Used by |
|----------|--------------|----------------|---------|
| cfitsio | `cfitsio::cfitsio` | system on Linux, `externals/` on macOS | tip, astro, st_facilities, irfs, flux, celestialSources, optimizers, timeSystem, Likelihood |
| CLHEP | `CLHEP::*` | `externals/` | astro, flux, celestialSources, irfs, evtbin, dataSubselector, optimizers, rspgen, observationSim, Likelihood, SolarSystemTools |
| GSL | `GSL::gsl` | `externals/` | st_facilities, Likelihood |
| FFTW | `FFTW::fftw3` | `externals/` | Likelihood |
| f2c | `f2c::f2c` | `externals/` | st_facilities (`dgaus8`), optimizers, Likelihood |
| healpix_cxx | `healpix_cxx::healpix_cxx` | `externals/` | astro, healpix |
| WCSlib | `WCSlib::WCSlib` | `externals/` | astro |
| CppUnit | `CppUnit::CppUnit` | `externals/` | tests in st_app, st_facilities, irfs, dataSubselector, Likelihood |
| Python 3 (≥ 3.7) + SWIG (≥ 3.0.1) | `Python3::Python` | system / conda | facilities, embed_python, st_graph, irfs (`pyIrfLoader`), Likelihood, pyLikelihood, pyExposure, BayesianBlocks |
| OpenMP | `OpenMP::OpenMP_CXX` | system (required) | healpix, Likelihood, Minuit2 |
| readline | `READLINE::READLINE` | system | ape |
| MPI | `MPI::MPI_CXX` | system (optional) | Minuit2 |
| ROOT | `ROOT::Core` | system, only with `FERMI_BUILD_ROOT=ON` (default `OFF`) | tip, celestialSources |

## Not built

- **`skymaps`** is a git submodule (`src/skymaps`) but is not listed in
  `FERMI_COMPONENTS`, so the CMake build never compiles it.
- **`pulsarDb`** and **`pulsePhase`** are commented out of
  `FERMI_COMPONENTS` and are not submodules.

## Keeping this document current

Regenerate the tables whenever you add or remove a package, or change a
`target_link_libraries` entry. If a change would make a package depend on a
package in a higher tier, rethink the change, or update the tier table here
and in the package's front matter and explain why.
