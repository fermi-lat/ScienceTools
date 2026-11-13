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
| [known-issues.md](known-issues.md) | triage bugs and gaps: every issue found in the package docs, by package, with severity and evidence |
| `build-and-release.md` *(planned)* | build, package or release the tools, or move a submodule pin |
| `externals.md` *(planned)* | change how a third-party library is built or found |
| [documentation-structure.md](documentation-structure.md) | write or update architecture docs |

## System overview

The packages fall into five tiers. Each tier may depend only on the tiers
below it. Full details are in [dependency-layers.md](dependency-layers.md).

```
 python       pyLikelihood · sane · modelEditor · pyBurstAnalysisGUI
 analysis     Likelihood · evtbin · dataSubselector · map_tools · rspgen · observationSim · …
 instrument   irfs · flux · celestialSources · catalogAccess
 io           tip · astro · healpix · st_facilities · fitsGen · timeSystem
 foundation   facilities · st_stream · ape · hoops · st_app · st_graph · xmlBase · embed_python · Minuit2 · optimizers
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

Every tool inherits the same failure behaviour from `st_app` (details and an
exit-status table are in the `st_app` doc):
- An exception from the app prints a message and exits with status 1.
  With `debug=yes` the exception is not caught, so the tool aborts (134).
- On Linux every tool is built with `TRAP_FPE`, so a floating-point divide
  by zero, invalid operation or overflow kills it with SIGFPE (136) and no
  message.
- With `gui=yes`, failures are printed but the exit status is 0.

Python users reach the same libraries through SWIG bindings (`pyLikelihood`,
`pyIrfLoader`, `py_facilities`) or through `sane`'s `gt_apps` wrappers, which
run the executables with their own par-file handling. Two Python traps:
importing `pyLikelihood` without conda activation kills Python through
`std::terminate`, because `irfs` reads CALDB in a static initializer; and after
`pyLikelihood.enableFPE()`, any floating-point exception, even inside numpy,
kills the interpreter with SIGFPE. By default
`GtApp.run()` detects failure only by looking for "at the top level:" in the
output, so a crash (exit 134, 136 or 139) counts as success. Pass
`catchError=None` to check the exit status instead.

### Runtime environment

Installed tools find their data through environment variables that conda
activation (`recipe/activate.sh`, which `recipe/build.sh` installs into
`etc/conda/activate.d`) sets, and through
`facilities::commonUtilities`. Package docs refer to this section rather
than repeat it.

| Variable | Set to (by `activate.sh`) | Used for |
|----------|---------------------------|----------|
| `FERMI_INST_DIR` (also `FERMI_DIR`, `INST_DIR`, `BASE_DIR`) | `$CONDA_PREFIX/share/fermitools` | Root of the **install** tree. `commonUtilities::getDataPath(pkg)` returns `$FERMI_INST_DIR/refdata/fermi/<pkg>`; `getXmlPath`/`getPfilesPath` resolve similarly. |
| `PFILES` | `.:$HOME/pfiles;$FERMI_INST_DIR/syspfiles`, or appended to an existing value | Parameter-file search path: local pfiles (left of `;`), then system pfiles. New local par files are written to the **first** local directory, which with the default value is the current directory, not `~/pfiles`. The full model is in `src/ape/doc/architecture/parameter-files.md`. |
| `CALDB`, `CALDBROOT`, `CALDBCONFIG`, `CALDBALIAS` | `$FERMI_DIR/data/caldb` and files under it | The LAT CALDB shipped by `irfs`. It is read during **static initialization** of `libirfLoader`, so a missing or wrong value aborts every tool that links it (and `pyLikelihood`) before `main` runs. `dataSubselector`'s `Cuts(file)` also needs it. |
| `TIMING_DIR` | `$CONDA_PREFIX/share/fermitools/refdata/fermi/jplephem` | JPL ephemerides (`JPLEPH.405`, `JPLEPH.200`) and the default leap-second table (`leapsec.fits`), used by `astro` and `timeSystem`. These files come from the separate **`fermitools-data`** package, not from this repo. Its `leapsec.fits` ends at 2012-07-01. `JPLEPH.405` covers 1949-12-14 to 2050-01-02. |
| `GENERICSOURCESDATAPATH` | `$CONDA_PREFIX/share/fermitools/data/genericSources` | Data for `celestialSources/genericSources`. Set **only** by activation: `setupEnvironment()` doesn't set it, and the data installs under `data/`, not `refdata/`, so `getDataPath` can't find it. |
| `EXTFILESSYS` | `$CONDA_PREFIX/share/fermitools/refdata/fermi` | Reference-data root. |

Things to know:
- **Data is found in the install tree, not the source tree.** A package's
  `data/` directory works only after `cmake --install`, and only if its
  `CMakeLists.txt` installs it to `refdata/fermi/<pkg>`.
- **If `FERMI_INST_DIR` is unset, paths become absolute garbage** such as
  `/refdata/fermi/<pkg>`, not empty strings, so "not found" checks in
  client code don't trigger.
- `commonUtilities::setupEnvironment()` fills in some of these variables
  if they are missing, but its fallback values are wrong (for example
  `CALDB`). In practice activation always sets them first. See the
  `facilities` doc.
- `scripts/activate.sh` is a separate variant for local developer installs,
  keyed on `$INSTALL_PREFIX`. It is not what the conda package uses.
- Some packages read their own variables (for example
  `IGNORE_IGRF_BOUNDARY` in `astro`). Each package doc lists these under
  *Public interfaces*.

### Testing

No package registers its tests with CTest. The project-level test harness
is **`recipe/tests/ST-unit-test`**, which the GitHub workflows
(`.github/workflows/testing-conda-st-unit.yml`, `python-test.yml`) run as
`ST-unit-test -w -d -v` in an installed conda environment. It:
- prepends `$CONDA_PREFIX/share/fermitools/syspfiles` to `PFILES`
- runs a fixed list of `test_*` programs (`unitTestsWithoutRoot` by
  default; `--with-root` selects the ROOT list), each in the current
  directory
- for some packages, calls a `check_test_<pkg>_output` function that
  `ftdiff`s named output files against
  `$CONDA_PREFIX/share/fermitools/data/<pkg>/outref`.

**Where the reference outputs come from.** Most `outref` data is not in the
package repos. It ships in the runtime **`fermitools-data`** conda package
(pinned in `recipe/meta.yaml`; version 0.18 verified from `conda-meta`),
which installs `outrefFiles/<pkg>/` from the `fermi-lat/fermitools-data`
repository to `share/fermitools/data/<pkg>/outref` for 14 packages. The
CI test environment (`environments/fermitools-testing.yml`) also installs
`fermitools-test-scripts-data`. Version 0.7 (built 2026-10-22) installs
copies of some of the same files plus the `Likelihood` regression-suite
data; 0.6 installs no `outref` at all. Which package owns the reference
data may be changing, so check `conda-meta/*.json` in the current test
environment before relying on this paragraph. `evtbin`, `rspgen`, `timeSystem` and `st_stream` install
their own `data/outref` to the same location. When a package's test outputs
change intentionally, update its reference files in the `fermitools-data`
repository and rebuild that package.

**Coverage of the default run** (`unitTestsWithoutRoot`):

| Package | Test program(s) run | Outputs compared (reference source) |
|---------|---------------------|-------------------------------------|
| embed_python | `test_embed_python` | — |
| facilities | `test_env`, `test_time`, `test_Util` | — |
| tip | `test_tip` | yes (fermitools-data) |
| astro, st_facilities, st_app, healpix, burstFit | `test_<pkg>` (exit status only) | — |
| st_graph | `test_st_graph`, run with no arguments, so it does nothing and always passes | — |
| st_stream | `test_st_stream` | text `diff` against its own `data/outref` (installed with the rest of `data/`) |
| xmlBase | `test_mem`, `test_write`, `test_xmlBase` | `test_write` (fermitools-data) |
| irfs | `test_irfLoader`, `test_irfInterface`, `test_latResponse`, `test_irfUtil` | — |
| flux | `test_flux` | existence check only (`testMgrOutput.out`) |
| celestialSources | `test_celestialSources`, `test_eblAtten`, `test_genericSources`, `test_microQuasar` | existence check only (`test_data.dat`, genericSources) |
| catalogAccess | `test_catalogAccess` | `test1out.fits` (fermitools-data); the package's own installed `data/outref` is unused |
| evtbin | `test_evtbin` | yes (own `data/outref`) |
| dataSubselector | `test_dataSubselector` | yes (fermitools-data) |
| map_tools | `test_map_tools` | yes (fermitools-data) |
| Likelihood | `test_Likelihood` | yes (fermitools-data) |
| rspgen | `test_rspgen` | `PHA1.pha` compared (own `data/outref`); the `.rsp` files are only checked for existence |
| Python | import checks only (`check_import_GtApp`, `check_import_pyLikelihood`, `check_import_UnbinnedAnalysis`, …; also `pyfits`, `Pmw`) | — |

**Not run by default:** `optimizers` and `timeSystem` (commented out of
both lists), `gtburst`'s import check (commented out), `fitsGen` and
`observationSim` (only in the `--with-root` list, which CI doesn't use), and
`ape`, `hoops`, `Minuit2`, `orbitSim`, `sourceIdentify`, `SolarSystemTools`,
`BayesianBlocks`, `pyExposure`, `modelEditor` and `sane`'s `test_sane`
(never listed). `skymaps` (not built) and `fermitools-fhelp` (no code) have
nothing to run. Because `test_optimizers` is commented out, Minuit2/`NewMinuit`
gets no coverage in the default Linux run (`test_Likelihood` uses it only on
macOS). Several test programs pass on exit status alone and assert
little; each package doc says what its test actually checks.

### Packaging

The conda recipe (`recipe/meta.yaml`, `recipe/build.sh`) defines things no
package's own CMake file shows: Python **console entry points**, run
requirements, and the activation scripts. Known problems as of this
writing (confirmed at runtime where noted in the package docs):
- the 23 `GtBurst.commands.X:__main__` entry points name a module guard,
  not a function, so those launchers fail at import
- `ObsSim = fermitools.ObsSim:main` points at a module that doesn't exist
- `modeleditor` needs Pmw and pyds9, which are not run requirements
- `xerces-c` and `readline` are still pinned although nothing links them
  (Xerces was replaced by RapidXML; ape's readline link is commented out)

Python packages install flat into `site-packages/fermitools`, and
`fermitools.pth` makes every installed module name importable at top
level, so a dead module can shadow a same-named third-party one.

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
| `facilities` | Low-level utilities. `commonUtilities` is how every package finds its installed data, XML and par files (see [Runtime environment](#runtime-environment)); also `Util` string helpers and the `py_facilities` SWIG module. Most packages reach it transitively through `tip`/`xmlBase`. | — | ✅ `src/facilities/doc/architecture/` |
| `st_stream` | Chatter-controlled, prefixable output streams (`stout`/`stlog`/`sterr`, `StreamFormatter`) used for all tool and library terminal output. No dependencies. | — | ✅ `src/st_stream/doc/architecture/` |
| `ape` | HEASARC parameter-file library in C (PIL-compatible API, Fortran bindings): par-file format, `PFILES` search, prompting and learning. Standalone CMake project (own export set, installs to `include/ape/`). | `pget`, `pset`, `plist`, `pquery`, `pquery2`, `punlearn`, `pcheck` | ✅ `src/ape/doc/architecture/` |
| `hoops` | C++ parameter interface over `ape` (`IPar`, `IParGroup`, `ParPromptGroup`, `Hexception`); `st_app::AppParGroup` derives from it. Throws on any signed/unsigned or integer/float conversion. | — | ✅ `src/hoops/doc/architecture/` |
| `st_app` | Application framework: supplies `main()` itself (in the static library), the `StApp` base class, `StAppFactory` registration, `AppParGroup`, chatter/debug/gui handling and parameter GUIs. Defines the exit-status contract for every tool. | — | ✅ `src/st_app/doc/architecture/` |
| `st_graph` | Engine-neutral plot and GUI interfaces, implemented only by a Tk/matplotlib engine (`MPLEngine`) in its own embedded Python interpreter. The only real plotting client is `gtburstfit`; `st_app` uses it for `gui=yes`. | — | ✅ `src/st_graph/doc/architecture/` |
| `xmlBase` | Vendored header-only RapidXML 1.13 plus header-only `xml_framework` helpers (`SafeXmlParser`, `XmlDomBuilder`, `XmlPrinter`). The only compiled code is `IFile`, which nothing uses. No schema/DTD validation. | — | ✅ `src/xmlBase/doc/architecture/` |
| `embed_python` | Static library with one class, `embed_python::Module`: import a Python module and read its variables into C++. Used only by `fitsGen`. | — | ✅ `src/embed_python/doc/architecture/` |
| `Minuit2` | Vendored standalone Minuit2 from ROOT 6.22/06, built as static `FermiMinuit2`/`FermiMinuit2Math`/`FermiMinuit2Common`; used only through `optimizers::NewMinuit`. Upstream docs apply. | — | ✅ `src/Minuit2/doc/architecture/` |
| `optimizers` | `Function`/`Parameter`/`Statistic` model classes used by every fit, and `Optimizer`s chosen by name through `OptimizerFactory`: Minuit (old Fortran, via f2c), NewMinuit (Minuit2), DRMNGB/DRMNFB (both run `ModNewton`), L-BFGS-B, Powell. Also `Mcmc`, `Amoeba`, and XML `FunctionFactory`. About half the code is f2c-translated Fortran. | — | ✅ `src/optimizers/doc/architecture/` |

### Tier 1: io

| Package | Purpose | Tools | Docs |
|---------|---------|-------|------|
| `tip` | Format-independent, iterator-based API for FITS tables, images and headers, built on cfitsio. | — | ✅ `src/tip/doc/architecture/` *(draft on `tip` branch `doc-updates`)* |
| `astro` | Astronomy primitives: `SkyDir`, sky projections (`SkyProj` via WCSlib, `HealpixProj` over healpix_cxx), `JulianDate`, `EarthOrbit`/`EarthCoordinate` (IGRF geomagnetic model, SAA), FT2 pointing history and the `GPS` singleton, `SolarSystem` (JPL DE405 ephemeris via `$TIMING_DIR`). | — | ✅ `src/astro/doc/architecture/` |
| `healpix` | Fermi C++ wrappers over healpix_cxx: `SkyDir`↔pixel mapping, `HealpixArray<C>`, the `CosineBinner` livetime-cube cell and its FITS I/O (every livetime-cube read goes through here), `HealpixRegion` partial-sky regions, and legacy spherical-harmonic code. | — | ✅ `src/healpix/doc/architecture/` |
| `st_facilities` | Shared utilities (STATIC library): file, `@filelist` and environment helpers, FITS convenience functions and `FitsImage`/`FitsTable` readers, interpolation, `dgaus8` quadrature (f2c), GSL `RootFinder`, CPU-time `Timer`. | — | ✅ `src/st_facilities/doc/architecture/` |
| `fitsGen` | Static library that writes FT1/FT2 (and LLE) FITS files from templates (`Ft1File`, `Ft2File`), plus `MeritFile` and an embedded-Python `EventClassifier`. Used only by `observationSim`. No tools: `makeFT1`/`makeFT2` and six other programs have no build target, but their par files are still installed. | — | ✅ `src/fitsGen/doc/architecture/` |
| `timeSystem` | Precise absolute times in TT/TAI/UTC/TDB (leap seconds; MJD/JD/calendar/ISO formats), plus geocentric and barycentric corrections from FT2 positions and JPL DE200/DE405. **The installed leap-second table ends in 2012**, so UTC conversions after 2017 are 2 s off. | `gtbary` | ✅ `src/timeSystem/doc/architecture/` |

### Tier 2: instrument

| Package | Purpose | Tools | Docs |
|---------|---------|-------|------|
| `irfs` | LAT instrument response functions (Aeff, PSF, Edisp, livetime efficiency) behind the abstract `irfInterface`, loaded by name from the **LAT CALDB that ships in this repo** (installed to `share/fermitools/data/caldb`). Sub-libraries: `irfInterface`, `irfUtil` (CALDB lookup), `latResponse` (Pass 8 implementation), `irfLoader` (registration); Python binding `pyIrfLoader`. Not thread-safe. | `gtirfs` | ✅ `src/irfs/doc/architecture/` |
| `flux` | Framework that turns XML source definitions into a time-ordered stream of incident particles for gtobssim, with a name-keyed registry of pluggable `ISpectrum` classes. **The July 2026 Xerces→RapidXML rewrite changed behaviour**: `<particle>` sources emit nothing, and only the first `<nestedSource>` is used. See its doc. | — | ✅ `src/flux/doc/architecture/` |
| `celestialSources` | Container of `flux` `ISpectrum` source classes for gtobssim: `genericSources` (maps, map cubes, diffuse, point, transient, periodic and population sources) plus the `eblAtten` EBL optical-depth library shared with `Likelihood`. The GRB, pulsar, microquasar and other sub-packages are **not built** or unreachable. | — | ✅ `src/celestialSources/doc/architecture/` |
| `catalogAccess` | In-memory `Catalog`/`Quantity` model read from FITS tables (via `tip`) or VizieR TSV/CSV text, with sky-region and value selection and export. Web access is a stub. **Text input is broken on 64-bit builds** (confirmed at runtime). | — | ✅ `src/catalogAccess/doc/architecture/` |

### Tier 3: analysis

| Package | Purpose | Tools | Docs |
|---------|---------|-------|------|
| `evtbin` | Binning events into histograms: light curves, spectra (PHA), counts maps and cubes, HEALPix maps. | `gtbin`, `gtbindef` | ✅ `src/evtbin/doc/architecture/` *(draft on `evtbin` branch `doc-updates`)* |
| `dataSubselector` | Event-selection library (`Cuts`/`CutBase`) that reads and writes the DSS keywords recording which cuts were applied. The DSS keywords are the cross-package contract that `Likelihood`, `rspgen`, `evtbin` and `pyLikelihood` rely on. Also computes GTIs. Reading cuts from a file needs `$CALDB`. | `gtselect`, `gtmktime`, `gtvcut` | ✅ `src/dataSubselector/doc/architecture/` |
| `orbitSim` | `gtorbsim`: simulates the Fermi orbit (SGP4 from a TLE, or FDF/STK ephemeris) and attitude (TAKO/ASFLOWN timelines or SURVEY/PROFILED/POINTED commands, with slew, Earth-avoidance and SAA models) and writes a simulated FT2. Its MET ignores leap seconds and `MJDREFF`. | `gtorbsim` | ✅ `src/orbitSim/doc/architecture/` |
| `map_tools` | Livetime-cube container `map_tools::Exposure`, the storage behind `gtltcube` and `Likelihood`'s `ExposureCube`; also a `SkyImage` WCS helper. Its two legacy tools barely work: `gtdispcube` only dumps a text table, and `exposure_cube` omits TSTART/TSTOP. Five more tools have par files but are not built. | `gtdispcube`, `exposure_cube` | ✅ `src/map_tools/doc/architecture/` |
| `burstFit` | `gtburstfit`: segments a `gtbin` light curve into Bayesian Blocks (`evtbin::BayesianBinner`), then fits a sum of Norris pulses plus background with χ²/Minuit; optional `st_graph` plots, no output file. **`fitguess=AUTO`/`CALC` builds a background-only model** (an ordering bug since 2015, confirmed at runtime); `fitguess=MAN` works. | `gtburstfit` | ✅ `src/burstFit/doc/architecture/` |
| `sourceIdentify` | `gtsrcid`: associates LAT sources with counterpart-catalog objects using the positional error ellipse, local counterpart density and a Bayesian posterior, with user expressions for prior, FoM and selections. **Always exits 0**; errors go only to `gtsrcid.log`. | `gtsrcid` | ✅ `src/sourceIdentify/doc/architecture/` |
| `rspgen` | `gtrspgen`: builds an OGIP RSP for a LAT PHA1 spectrum from the IRFs, the FT2 file and the spectrum's DSS keywords, in point-source or burst mode. Normalized so counts = flux × EXPOSURE × R. No package includes its headers. | `gtrspgen` | ✅ `src/rspgen/doc/architecture/` |
| `observationSim` | `gtobssim`: Monte Carlo LAT observations. Draws photons from `flux`/`celestialSources` XML models, thins them by Aeff × livetime (SAA excluded), samples the PSF and energy dispersion from `irfs`, and writes FT1 (and FT2 in orbit mode) via `fitsGen` with DSS keywords from `dataSubselector`. Orbit mode fails after Dec 2024 because of the expired IGRF model (see `astro`). | `gtobssim` | ✅ `src/observationSim/doc/architecture/` |
| `Likelihood` | C++ library for binned and unbinned maximum-likelihood analysis of LAT data, plus the livetime-cube, exposure, source-map, weights and TS-map machinery behind it. Topic files cover models, unbinned and binned analysis, exposure, and every tool. **`gtexpcube2 irfs=CALDB` always fails** (an argument inverted in 2017; confirmed at runtime); pass an explicit IRF name. Not parallel: it links OpenMP but never uses it. | `gtlike`, `gtltcube`, `gtltsum`, `gtexpmap`, `gtexpcube2`, `gtsrcmaps`, `gtmodel`, `gtdiffrsp`, `gtpsf`, `gtdrm`, `gtsrcprob`, `gtfindsrc`, `gttsmap`, `gttscube`, `gthealcube`, `gtwtsmap`, `gtbkg`, `gteffbkg`, `gtalphabkg`, `gtebl` | ✅ `src/Likelihood/doc/architecture/` |
| `BayesianBlocks` | Standalone C++ Bayesian Blocks (Jackson/Scargle 2005, Scargle 2013 prior) for events, binned data and point measurements, used through its SWIG module, plus a pure-Python twin. Its CMake links (Likelihood, irfs, astro, st_facilities) are all unused. One of three independent Bayesian Blocks implementations (also `evtbin::BayesianBinner`, `GtBurst.BayesianBlocks`). Its installed scripts need `pyfits`. | — | ✅ `src/BayesianBlocks/doc/architecture/` |
| `pyExposure` | `gtexposure`: adds a spectrally weighted `EXPOSURE` column (cm² s) to a `gtbin` light curve **in place**, via a small C++ library. Despite the name it has no working Python interface: the SWIG module is not built and its scripts are not installed. Segfaults on an unknown `irfs` name (confirmed at runtime). | `gtexposure` | ✅ `src/pyExposure/doc/architecture/` |
| `SolarSystemTools` | Livetime and exposure cubes binned in angle from the Sun or Moon (JPL DE405), plus Sun/Moon intensity templates for likelihood. **`gtexpcubesun` dies with SIGFPE for `thetasunmax` > 57.3°, including the default 180** (radians passed where cos θ is expected; confirmed at runtime). | `gtltcubesun`, `gtltsumsun`, `gtexpcubesun`, `gtexphpsun`, `gtsuntemp` | ✅ `src/SolarSystemTools/doc/architecture/` |

### Tier 4: python

| Package | Purpose | Tools | Docs |
|---------|---------|-------|------|
| `pyLikelihood` | SWIG module exposing `Likelihood` plus parts of `optimizers`, `astro`, `st_app`, `dataSubselector`, `healpix`, `map_tools`, `st_facilities` and `irfs` (`IEfficiencyFactor` only), and the Python analysis layer (`UnbinnedAnalysis`, `BinnedAnalysis`, `SummedLikelihood`, `LikelihoodState`, upper limits, SED). Installed flat into `site-packages/fermitools`. The authoritative list of what is wrapped is in its `swig-interface.md`. | — | ✅ `src/pyLikelihood/doc/architecture/` |
| `sane` | Pure-Python `GtApp`/`gt_apps` wrappers that run the gt tools with their own par-file parser, plus XML model helpers. Installed to `site-packages/fermitools`. Its `test_sane` end-to-end test cannot run today; CI only checks that `GtApp` and `gt_apps` import. | — | ✅ `src/sane/doc/architecture/` |
| `modelEditor` | Tkinter/Pmw GUI for creating and editing Likelihood XML source models (1FGL–3FGL catalog import, DS9 via pyds9, export to gtobssim format). **Does not start in a stock conda environment**: Pmw and pyds9 are not run requirements (confirmed at runtime). Saving silently drops unknown attributes. | `modeleditor` | ✅ `src/modelEditor/doc/architecture/` |
| `pyBurstAnalysisGUI` | gtBurst: a GUI plus about 23 key=value Python commands for downloading and analysing GBM/LLE/LAT GRB and solar-flare data. Drives the gt tools through `sane`'s `GtApp` and fits through `pyLikelihood`. Has a self-updater that overwrites installed files from GitHub. Only `gtburst` launches; the 23 other console scripts fail at import (use `python -m GtBurst.commands.X`). | `gtburst` (+23 broken console scripts) | ✅ `src/pyBurstAnalysisGUI/doc/architecture/` |

### Support

| Package | Purpose | Docs |
|---------|---------|------|
| `fermitools-fhelp` | Plain-text `fhelp` files for each tool (`fhelp_files/<tool>.txt`), installed to `share/fermitools/help`. Changes to tool help belong here. Several have drifted from the par files. | ✅ `src/fermitools-fhelp/doc/architecture/` |

### Not built

`skymaps` is a submodule in `src/`, but it is not part of the CMake build
(see [dependency-layers.md](dependency-layers.md#not-built)). It is a legacy
pointlike-era C++/SWIG library. Docs: ✅ `src/skymaps/doc/architecture/`.

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
