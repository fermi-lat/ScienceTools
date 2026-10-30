# Update the architecture docs for this branch

You are updating the architecture documentation of a Fermitools
(ScienceTools) repository so that it matches the changes made on the current
branch. The docs are read by both human developers and AI agents before they
work on the code, so accuracy matters more than polish.

## 1. Establish the context

1. **Which repository are you in?**
   - Run `git rev-parse --show-toplevel` and
     `git rev-parse --show-superproject-working-tree`.
   - If the superproject command prints a path, you are in a **package**
     (a submodule of ScienceTools). The package name is the directory name;
     its docs are in `doc/architecture/`. The ScienceTools system docs are in
     `<superproject>/docs/architecture/`.
   - If it prints nothing and the repository contains
     `docs/architecture/documentation-structure.md`, you are in the
     **ScienceTools umbrella**. Its docs are `docs/architecture/`.
   - If it prints nothing and there is no such file, you are in a package
     checked out on its own. Its system docs are unavailable; see step 6.
2. **Read the rules.** Read `documentation-structure.md` (in the ScienceTools
   `docs/architecture/` directory) in full, especially the README template,
   "Front matter notes" and "Writing guidance". Follow them.
3. **Find the branch's changes.**
   - Determine the base branch: `origin/HEAD`, otherwise `origin/master` or
     `origin/main`. Compute `BASE=$(git merge-base HEAD <base>)`.
   - Collect `git log --oneline $BASE..HEAD`, `git diff --stat $BASE`, and
     the full `git diff $BASE`. That diff includes uncommitted work, which is
     intended.
   - If there are no changes, say so and stop.
4. **Read the current docs**: every file in the repository's
   `doc/architecture/` (or `docs/architecture/` for the umbrella).

## 2. Decide what the changes affect

Classify each change. For each class, check the doc sections listed.

| Kind of change | Check and update |
|----------------|------------------|
| New, removed or renamed class, header, function or public API | *Key abstractions*, *Public interfaces*, the class/type tables and diagrams, and the topic files that cover it |
| Behaviour change (algorithm, defaults, units, error handling, output format) | *Data flow and control flow*, *Public interfaces*, *Invariants and gotchas*, and any topic file that describes it |
| New, removed or changed tool, or par file (`pfiles/*.par`) | The tools table, parameter descriptions, exit-status notes, and the README's tool list |
| `CMakeLists.txt`: targets, link libraries, install rules | Front matter `depends_on` / `test_depends_on`, *Position in the system*, *Build and test*, and install destinations |
| New or removed `#include` of another package, or SWIG `%include` | `depends_on`, *Position in the system* (real use vs link-only vs include-only vs tests-only) |
| Tests or test data (`src/test`, `data/`, `data/outref`) | *Build and test*, including how `recipe/tests/ST-unit-test` exercises the package |
| New `getenv` call or environment variable | *Public interfaces* → *Environment variables* |
| A bug fixed | Remove or update the gotcha that described it |
| A new limitation, workaround or suspected bug | Add a gotcha, marked with its evidence (see below) |
| Code moved between files | Every file and function reference in the docs that points at the old location |
| Umbrella only: `recipe/`, CI workflows, `ST-unit-test`, top-level `CMakeLists.txt`, submodule list | ScienceTools `README.md` (Runtime environment, Testing, Packaging, package index), `dependency-layers.md`, `known-issues.md` |

Also check whether the change makes any **existing** statement in the docs
false, even in a section the change doesn't obviously touch. Grep the docs
for the names of changed functions, classes, files, parameters and tools.

## 3. Verify before writing

- Base every statement on the code as it is now on this branch, not on the
  commit messages or old comments. Open the changed files and read enough
  surrounding code to be sure.
- Mark evidence as the guidance requires: "(confirmed at runtime)" only if
  you actually ran it; "(from reading the code; not checked at runtime)" for
  suspected bugs you could not confirm.
- Don't run anything slow or anything that writes outside a scratch
  directory. A seconds-long run on tiny inputs, in a temporary directory, to
  confirm a behaviour is fine.
- For `depends_on` and `used_by`, use the methods in "Front matter notes":
  check library links against the library's own sources, and find consumers
  through `#include`, `<pkg>::` symbol use, SWIG `.i` files and Python
  imports across the ScienceTools `src/` tree when it is available.

## 4. Edit the package docs

- Make the **smallest set of edits** that brings the docs in line with the
  code. Keep the existing structure, headings, tone and level of detail. Do
  not rewrite sections that are still correct.
- Keep the README's eight template sections in order. If a topic file covers
  the changed area, update the topic file and keep the README's summary
  consistent with it.
- If the package has no `doc/architecture/README.md` yet, create one from
  the template in `documentation-structure.md`.
- Update the front matter:
  - `depends_on`, `test_depends_on` and `used_by` if they changed.
  - `summary` if the package's one-line purpose changed.
  - `last_reviewed_commit`: set it to the short SHA of `HEAD` (the commit
    whose code you reviewed). If there are uncommitted code changes, append
    `+uncommitted` and tell the developer to replace it with the final
    commit's SHA.
- Do not change code, tests, build files or anything outside the docs.

## 5. Update the ScienceTools system docs (if available)

If the ScienceTools `docs/architecture/` directory is available, update it
where the branch's changes affect it:

- `README.md`: the package's index row (purpose, tools, notable warnings),
  and the Runtime environment, Testing or Packaging sections if those changed.
- `dependency-layers.md`: the package's row in the full table, the diagrams,
  and the tier, if dependencies changed. A package may not depend on a
  higher tier; if a change would do that, flag it prominently rather than
  silently moving the package.
- `known-issues.md`:
  - **Fixed issue:** delete its row. Don't renumber the remaining IDs; they
    are stable handles.
  - **New issue:** add a row with the next unused ID for that package and the
    same columns (ID, severity, issue, where, evidence), using the severity
    definitions at the top of the file.
  - **Changed issue:** update its row.
  - Update the summary counts and the High-severity table to match.
- `documentation-structure.md`: only if you found a lesson that would apply
  to other packages. Add it to "Writing guidance" and mention it in your
  report.

These files belong to the ScienceTools repository. If you are in a package,
your edits there will be a **separate change in a separate repository**;
say so clearly in your report.

## 6. If the system docs are unavailable

If the package is checked out on its own, update only its own docs. In your
report, list the changes that should be made to the ScienceTools system docs
(index row, dependency table, known issues) so the developer can make them
there.

## 7. Report

Finish with a short report:

1. **Repository and range reviewed**: repository, base, `HEAD`, and number of
   commits.
2. **Doc changes made**, per file: one line each saying what changed and why.
3. **ScienceTools changes**: edits made there (separate repository and PR),
   or changes the developer still needs to make.
4. **Issues**: issues fixed by this branch (removed from the docs), and new
   issues or suspected bugs found (added), with their evidence level.
5. **Needs a human**: anything you could not verify, statements you were
   unsure how to update, or changes to the code you think the docs reveal
   are needed (for example a newly broken tier rule).

If the branch's changes need no doc updates, say so, and explain briefly why
in item 2.
