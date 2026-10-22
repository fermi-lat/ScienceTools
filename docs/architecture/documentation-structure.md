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
- **Large packages** (e.g. `Likelihood`, `irfs`, `flux`) split into topic
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
layer: <foundation | io | instrument | analysis | application | python>
depends_on: [<pkg>, ...]
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
anything that commonly trips up new contributors.

## Extension points
How to add common things: a new spectral function, IRF, application,
source type, etc.

## Further reading
Topic files in this directory, relevant ADRs, papers, and external docs.
```

### Front matter notes

- `depends_on` / `used_by` should match the actual CMake dependencies and be
  reflected in the Level 1 package index.
- `last_reviewed_commit` lets readers (and tooling) judge staleness: if the
  package has changed substantially since that commit, treat the docs with
  caution and update them.

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

## Relationship to agent instruction files

If `CLAUDE.md`, `AGENTS.md`, or similar files are added, keep them short and
point here, for example:

> Before working in `src/<pkg>`, read `src/<pkg>/doc/architecture/README.md`.
> For cross-cutting concerns, read `docs/architecture/README.md`.

## Rollout plan

1. Land this document on the `doc-updates` branch of ScienceTools.
2. Pilot the template on one mid-sized package and refine the template based
   on what was awkward.
3. Write the Level 1 `README.md` package index and `dependency-layers.md`.
4. Roll out to remaining packages, prioritizing those under active
   development.
