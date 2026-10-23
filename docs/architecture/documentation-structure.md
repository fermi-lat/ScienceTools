# Architecture & Design Documentation Structure

This document defines where architecture and design documentation for the
Fermitools lives, how it is organized, and what each document must contain.
The goal is that a developer — human or AI agent — about to work on part of
the ScienceTools can find and read the documentation for *that part* without
wading through a single monolithic document.

These documents are not `CLAUDE.md` or `AGENTS.md` files. If such files are
created later, they should point at the documents described here rather than
duplicate them.

## Guiding principles

1. **Compartmentalized.** Each package documents itself. Cross-cutting,
   system-level material lives in one place at the top level.
2. **Co-located and versioned with the code.** Package docs live in the
   package's own repository, so the documentation pinned by a ScienceTools
   submodule commit always describes the code at that commit, and doc updates
   can ship in the same PR as the code change.
3. **Predictable paths.** The entry point for any package is always
   `src/<pkg>/doc/architecture/README.md`. No searching required.
4. **Uniform shape.** Every package entry point uses the same section headings
   so readers know where to look.
5. **Plain Markdown.** Readable on GitHub, in an editor, by an agent, and
   rendered by Doxygen.

## Two levels of documentation

### Level 1 — System docs (this repository)

Location: `docs/architecture/` in the ScienceTools umbrella repo.

Covers what no single package owns:

| File | Contents |
|------|----------|
| `README.md` | System overview and **package index**: every package with a one-line purpose, its layer, and the path to its own architecture docs. |
| `dependency-layers.md` | Package dependency graph and layering (e.g. `facilities`/`st_facilities`/`tip`/`astro` → `irfs`/`optimizers` → `Likelihood` → `pyLikelihood`), and where applications sit. |
| `build-and-release.md` | CMake build, `cmake/` helpers, conda `recipe/` and `environments/`, submodule pinning workflow, CI/CD. |
| `externals.md` | How third-party externals (`cfitsio`, `clhep`, `cppunit`, `gsl`, `wcslib`, `fftw`, `f2c`, `healpix_cxx`) are wrapped and built. Integration only — not upstream internals. |
| `known-issues.md` | Every issue recorded in the package docs, by package, with stable IDs, severity and evidence, for triage. |
| `documentation-structure.md` | This document. |
| `decisions/` | System-level architecture decision records (ADRs). |

### Level 2 — Package docs (each submodule repository)

Location: `src/<pkg>/doc/architecture/` inside each package's own repo.

Nearly every package already has a `doc/` directory (holding `release.notes`
and, in some cases, Doxyfiles or LaTeX notes); `architecture/` is added
alongside. Note the spelling: packages use `doc/` (singular), the umbrella
repo uses `docs/`. Each repo keeps its existing convention.

```
src/<pkg>/doc/architecture/
  README.md        # required: entry point, follows the template below
  <topic>.md       # optional: deep dives for large packages
  decisions/       # optional: package-level ADRs, NNNN-short-title.md
```

- **Small packages** (e.g. `st_stream`, `hoops`, `st_graph`) need only
  `README.md`.
- **Large packages** (e.g. `Likelihood`, `irfs`, `celestialSources`) split into topic
  files, with `README.md` serving as their overview and index
  (e.g. `Likelihood/doc/architecture/binned-analysis.md`, `source-maps.md`).

**Vendored upstream code** (e.g. `Minuit2`) and **externals** are not given
full architecture docs; upstream documentation is authoritative. If Fermi
has local modifications or integration concerns, document those briefly in
the package's `README.md` or in `docs/architecture/externals.md`.

## Package `README.md` template

Every package entry point begins with front matter and uses these sections,
in this order. A section that genuinely does not apply should be kept with a
one-line "Not applicable" note rather than removed, so readers can tell it was
considered.

```markdown
---
package: <pkg>
summary: <one line>
layer: <foundation | io | instrument | analysis | python | support>
depends_on: [<pkg>, ...]
test_depends_on: [<pkg>, ...]
used_by: [<pkg>, ...]
last_reviewed_commit: <short sha of this package when docs were last verified>
---

# <pkg> Architecture

## Purpose and scope
What the package does, and what it deliberately does not do.

## Position in the system
Upstream dependencies and downstream consumers, by package name, and why
each dependency exists.

## Key abstractions
The principal classes/modules and how they relate. A small diagram
(Mermaid or ASCII) is encouraged for non-trivial packages.

## Data flow and control flow
How a typical call or application run moves through the code, e.g.
par file → `st_app` → application class → core library → output FITS.

## Public interfaces
- C++ API: the headers in `<pkg>/` that other packages include.
- Applications: executables and their par files in `pfiles/`.
- Python: SWIG bindings or pure-Python modules exposed.
- File formats read or written.

## Build and test
CMake targets, test executables, location of test data (`data/`), how to
run the tests, and any known flaky or slow tests.

## Invariants and gotchas
Non-obvious constraints, numerical subtleties, historical quirks, and
anything that commonly trips up new contributors. Group entries under bold
sub-headings by topic (e.g. **Ownership and lifetime**, **Null values**,
**Performance**) once there are more than a handful.

## Extension points
How to add common things: a new spectral function, IRF, application,
source type, etc.

## Further reading
Topic files in this directory, relevant ADRs, papers, and external docs.
```

### Front matter notes

- `layer` is one of the tiers defined in
  [dependency-layers.md](dependency-layers.md#tiers).
- `depends_on` lists what the package's library and applications actually
  use. `test_depends_on` lists packages needed only by tests (e.g. `tip`
  links `facilities` solely so its test program can locate data). Omit
  `test_depends_on` if empty. Together they should account for every
  `target_link_libraries` entry in the package's `CMakeLists.txt`; if the
  CMake linkage is broader than actual use, say so in the *Position in the
  system* section. Check each **library** link against the library's own
  sources, not the tests': a test-only link hidden in the library's link
  list can put a package in the wrong tier (this happened with
  `optimizers`). Ignore commented-out CMake lines.
- `used_by` should be derived from actual use across `src/`:
  `#include "<pkg>/..."`, namespace use (`grep '<pkg>::'`, since PUBLIC
  links pass headers on and some consumers never include them directly),
  SWIG `.i` files (`%include`/`#include`), and Python `import`s. In
  *Position in the system*, distinguish consumers that **use** the package
  from those that are **link-only**, **include-only** (headers included
  but no symbols used), or **tests-only**. The front-matter list holds
  only real users. Reflect the result in the Level 1 package index.
- `last_reviewed_commit` lets readers (and tooling) judge staleness: if the
  package has changed substantially since that commit, treat the docs with
  caution and update them.

## Writing guidance

Lessons from the pilot (`tip`):

- **Verify against the code, not the old docs.** Existing Doxygen mainpages
  and release notes are often decades old and describe intent rather than
  behavior (e.g. `tip`'s mainpage promises buffering that is actually
  cfitsio's). Cite the file (and function) that backs each non-obvious
  claim.
- **Distinguish verified from inferred.** If a behavior was determined by
  reading code but not exercised at runtime, say so inline. This keeps
  suspected bugs from being read as established fact.
- **Document suspected bugs as gotchas, don't fix them in a docs change.**
  Note the symptom and location; fixes belong in their own PR.
- **"Invariants and gotchas" is usually the most valuable section.** Prefer
  concrete, silent-failure behaviors (fallbacks, sentinels, stale caches,
  surprising assignment semantics) over general advice.
- **Show the idiomatic usage**, especially when the naive usage is slow or
  wrong.
- **Record how tests actually run**: whether they are registered with CTest,
  required environment variables, where test data is resolved from, and
  where scratch output is written. Say which test functions are actually
  compiled and run: code inside `#if 0` and commented-out test
  registrations hide large coverage gaps.

Lessons from the foundation and io tiers:

- **List environment variables.** Grep the package for `getenv` and list
  each variable and its effect under *Public interfaces* (for example
  `astro` reads `TIMING_DIR`, `IGNORE_IGRF_BOUNDARY` and `ZENITH_FRAME_FIX`).
  Variables set by conda activation are described once, in
  [README.md](README.md#runtime-environment); link there rather than
  repeat them.
- **Check data with an expiry date** (leap-second tables, geomagnetic
  models, ephemeris ranges) against the current date, and give the date or
  MET at which the code stops working. `astro`'s IGRF model stopped at the
  start of 2025.
- **Separate generated, vendored and hand-written code.** For f2c
  translations, vendored upstream code (RapidXML, Minuit2) and generated
  tests, say which files are generated, which are built and which are
  reference only. Report the size of what is actually compiled, so unbuilt
  or generated code doesn't make the package look bigger than it is. Look
  for duplicate copies of vendored sources in other packages (two
  `dgaus8.c` copies define the same symbols), and check patches in
  `externals/` that change types (f2c's `integer` is patched to `int`).
- **Vendored upstream packages get a lighter README** that covers
  provenance, Fermi build integration, local changes against upstream and
  gotchas, not upstream internals (see `Minuit2`, `ape`).
- **Check install destinations.** `getDataPath(pkg)` looks in
  `refdata/fermi/<pkg>`; a `data/` directory installed anywhere else won't
  be found at runtime.
- **List dead code that ships**: installed headers that no longer compile
  or have no users, and committed build artifacts.
- **Look for unmerged fix branches** (`git branch -a`) that change behaviour
  the doc describes, and mention them.
- **Framework packages document their error contract** as a table (exit
  status, what gets printed, debug and GUI differences), because the tool
  docs and scripts depend on it. See `st_app`.

Lessons from the instrument and analysis tiers:

- **Container packages open with a sub-package table**: CMake target,
  whether it is built, whether it is reachable (registered, linked, its
  factory actually referenced), ROOT-only, or dead. "Built but never
  reachable" is a separate category from "not built". In static-library
  plugin registries, compiled is not the same as available (see `irfs`,
  `celestialSources`).
- **A consumer whose only use is in an unbuilt source file is link-only.**
  Check that the including file is actually compiled (`add_executable` or
  `add_library` source list). Likewise, look for tools whose par files are
  installed but which have no build target.
- **Diff recent rewrites against the pre-rewrite commit.** When a package
  has had a replacement or rewrite PR (for example Xerces→RapidXML in
  `flux`), silently lost defaults and fallbacks are the most valuable
  gotchas. Name the downstream tool or test that would catch a regression.
- **Shared file-format contracts get their own topic file** with a table of
  who reads and who writes them, even in a mid-sized package (see
  `dataSubselector/doc/architecture/dss-keywords.md`).
- **Find out how the package is really tested.** Grep
  `recipe/tests/ST-unit-test` for the package's `test_*` program and any
  `check_test_<pkg>_output` function, and state which outputs are compared
  against `outref`, and where that reference data comes from: most of it
  ships in the runtime `fermitools-data` conda package (from
  `outrefFiles/<pkg>/` in the `fermitools-data` repository), not in the
  package (see [README.md](README.md#testing)). To find which conda package
  really installs a file, check `conda-meta/*.json` in an installed
  environment rather than inferring it from repository layout. Note test programs installed to `bin/`.
- **Check that tools signal failure through their exit status.** Tools
  with C-style status codes that never throw (for example `gtsrcid`) bypass
  the `st_app` contract and always exit 0.
- **Look for work done in static initializers and destructors.** A file
  read in a static initializer (the `irfs` CALDB load) aborts the process
  before `main` runs. Output written in a destructor turns an exception
  into `std::terminate` and can lose other outputs (`observationSim`).
- **Check external data packages, not just code.** When a package depends
  on data from another package (for example leap seconds and ephemerides
  from `fermitools-data`), open the installed file and check its last
  entry. Packages that hand-roll MJD↔MET conversions should be checked for
  `MJDREFF` and leap-second handling.
- **Monte Carlo packages document their RNG**: engine, how it is seeded,
  and what changes the random sequence.
- **Check the copy semantics** of classes that cache raw pointers into
  their own members (`map_tools::Exposure`, `irfs` `Edisp3`).
- **Integer enumerations that users write in XML or par files are an
  interface.** Flag them as append-only.
- **Effective compile definitions can come from PUBLIC dependencies** (for
  example `tip` exports `BUILD_WITHOUT_ROOT`). Check them, not just the
  package's own CMake file.
- **Small runtime checks are welcome.** If an installed Fermitools
  environment is available, a seconds-long run on tiny inputs can confirm
  or refute a suspected bug. Run it outside the repo and mark the finding
  "(confirmed at runtime)".

Lessons from the Python and application packages:

- **SWIG packages: separate what is wrapped from what is only included.**
  Check every `%include` against headers that are only `#include`d, and
  say which classes Python actually gets. Several docs initially
  overstated this; `pyLikelihood`'s `swig-interface.md` is the reference.
  Grep Python code (in the package and its consumers) for flat
  `Class_method` calls, which SWIG ≥ 4.1 no longer generates.
- **Check the package's name against its contents.** `pyExposure` has no
  working Python interface; its tier had been chosen from its name.
- **The tier reflects the package's role, limited by its dependencies.** A
  package may sit in a higher tier than its dependencies require (for
  example `BayesianBlocks`, whose CMake links are all unused, stays in
  `analysis` as a science algorithm), but never in a lower one.
- **Run each installed entry point in the reference environment.** Console
  scripts and run requirements are defined in the umbrella
  `recipe/meta.yaml` (see [README.md](README.md#packaging)) and can be
  broken even when the package code is fine. Smoke-test tools at their
  **default** parameters; several failures appear only with defaults.
- **Python packages: compare the installed layout with the paths the code
  computes** (for example `packagePath()` points at `$FERMI_INST_DIR/<pkg>`,
  but `python/` installs to `site-packages/fermitools`). List installed
  modules that are dead or fail to import; `fermitools.pth` makes every
  installed module name top-level.
- **Check the tool's help text against the code.** Comparing
  `fermitools-fhelp` with the implementation turned up real conflicts (for
  example in `SolarSystemTools`).
- **Signs that `clobber` is ignored:** an unconditional `std::remove(outfile)`
  or an overwrite of an input file. Say so explicitly.
- **Tools driven through `sane`'s `GtApp`:** its default mode detects failure
  by scanning output for "at the top level:", so a crash (exit 134, 136 or
  139) counts as success. Note this wherever a tool can crash.
- **Record what changes results without changing code**: environment
  variables, and process-wide caches or singletons (for example `Likelihood`'s
  `WcsMapLibrary`, the IRF phi-dependence flag, `CosineBinner`'s static
  binning). Say which ones can change the numbers a tool produces.
- **Record network endpoints and self-updating code** in a table: URLs, what
  they serve, and whether they still respond (see `pyBurstAnalysisGUI`).
- **Check `install(DIRECTORY)` rules for lost executable permissions** on
  scripts that are run as programs.

## Cross-references

- **Inside a package**, link to sibling files with relative links
  (`[binned analysis](binned-analysis.md)`).
- **Between packages**, refer to the other package by name and by its path
  from the ScienceTools root, e.g. "see `src/tip/doc/architecture/`".
  Relative links across submodule boundaries work in a local checkout but not
  on GitHub (submodule links resolve to a commit page), so do not rely on them
  being clickable.
- **From the Level 1 index**, list each package's path; the same caveat
  applies on GitHub.

## Architecture decision records

Use ADRs for decisions with lasting consequences (a dependency change, a
file-format change, a build-system choice). Place them in `decisions/` at the
appropriate level, numbered `NNNN-short-title.md`, with sections: *Status*,
*Context*, *Decision*, *Consequences*. Do not rewrite accepted ADRs; supersede
them with a new one.

## Doxygen

The top-level `docs/Doxyfile` uses `INPUT = ../src` with `RECURSIVE = YES` and
includes `*.md` in `FILE_PATTERNS`, so these Markdown files are picked up and
rendered as Doxygen pages automatically. Check that they do not collide with
the existing `src/<pkg>/src/mainpage.h` pages; add `EXCLUDE_PATTERNS` if they
do.

## Maintenance workflow

1. Update a package's architecture docs in the same PR as the code change
   that invalidates them, and bump `last_reviewed_commit`.
2. After merging in the package repo, bump the submodule pin in ScienceTools
   as usual; the docs travel with the pin.
3. If a change alters a package's dependencies, layer, or one-line purpose,
   also update the Level 1 package index in `docs/architecture/README.md`.
4. When a change fixes or introduces an issue, update both the package doc's
   gotchas and its row in `docs/architecture/known-issues.md`.

## Relationship to agent instruction files

If `CLAUDE.md`, `AGENTS.md`, or similar files are added, keep them short and
point here, for example:

> Before working in `src/<pkg>`, read `src/<pkg>/doc/architecture/README.md`.
> For cross-cutting concerns, read `docs/architecture/README.md`.

## Rollout plan

1. Land this document on the `doc-updates` branch of ScienceTools.
2. Pilot the template on one mid-sized package and refine the template based
   on what was awkward. *(Done: `tip`, then `evtbin`. Feedback is folded into
   the template front matter, the gotchas section guidance, and
   [Writing guidance](#writing-guidance).)*
3. Write the Level 1 `README.md` package index and `dependency-layers.md`.
   *(Done.)*
4. Roll out to remaining packages. *(Done 2026-10-22: all 38 submodules have
   `doc/architecture/` on their `doc-updates` branches, followed by a
   consistency sweep against the final Writing guidance.)*
5. Still to do: `build-and-release.md` and `externals.md` (listed in the
   Level 1 table), merging each package's `doc-updates` branch, bumping the
   submodule pins, and keeping docs current as code changes (update
   `last_reviewed_commit` and the package index row in the same PR).
