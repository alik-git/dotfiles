---
name: ali-code-review
description: Review code with Ali's preferred senior-engineer standard: first check for basic hygiene that should be automated, then look hard for correctness bugs, stale code, bad abstractions, needless complexity, misplaced logic, docs drift, and compatibility layers that should be deleted or simplified.
---

# Ali Code Review

Review like a fresh senior engineer reading the code for the first time. Assume
the authors are competent, then look for the things that still feel clearly
wrong, fragile, stale, overcomplicated, misplaced, or embarrassing enough that
they should be fixed before review or merge.

## Review Flow

1. Define the boundary: PR, branch, diff, commit range, feature, or whole repo.
   Do not silently narrow a whole-repo review.
2. Inspect the actual code, docs, tests, config, examples, and command surface.
   Do not rely on memory or prior review findings for volatile repo state.
3. Run or recommend the basic gates that fit the repo. These should catch
   hygiene problems before human design review.
4. Then use judgment: correctness, architecture, ownership, simplification,
   naming, and whether the system is solving the right problem.
5. Report findings by severity. Be honest about residual risk and checks that
   were not run.

## Basic Gates

Look for missing or weak automation around:

- Formatting: formatter check, not only linter check.
- Linting: normal linter plus project-specific rule sets.
- Typing/imports: mypy, pyright, import smoke tests, stale imports.
- Dead code: vulture, unused modules, deleted-module references, dead CLI paths.
- Docstrings: public modules, classes, functions, and tests when the repo
  requires them; reject empty one-liners on complex functions.
- Docs drift: README/docs/examples/smoke docs that describe old commands,
  old artifact semantics, old config names, or old workflow assumptions.
- CLI drift: help text, parser wiring, aliases, examples, and command names.
- Pipeline/config drift: golden configs, smoke configs, recipe names, view rules,
  and hidden defaults that no longer match the implementation.
- Generated/local files: temp dumps, plans, logs, local data, and scratch output
  should stay out of tracked source unless explicitly intentional.

If a repo lacks an obvious gate for a repeated failure mode, call that out as a
real review finding. Prefer "add a check/test" over "remember to review this
manually" for basic hygiene.

## Design Questions

Ask these directly while reading:

- Why does this abstraction/file/function exist?
- Is it solving the real problem, or preserving old machinery?
- Could this be one source of truth instead of duplicated state?
- Is this hidden magic where an explicit command/config/step would be clearer?
- Is business logic living in CLI, parser, tests, examples, or glue code?
- Is the name still true now that the module's responsibility changed?
- Is this split by real responsibility, or just split because a file got long?
- Is this file too tiny to justify itself, such as only re-exporting one thing?
- Is a large file actually cohesive and readable enough to keep together?
- Is compatibility the only reason this code still exists?
- Would deleting code, removing a fallback, or making a clean break improve the
  repo more than adding another layer?

Large but cohesive domain modules are fine. Dense code can be fine. Split code
because responsibilities differ, not because line count alone is uncomfortable.

## What To Flag

- Correctness bugs, edge cases, stale state, invalidation mistakes, and missing
  checks around data, artifacts, configs, views, stats, or generated outputs.
- Hidden behavior: implicit dependency generation, silent fallbacks, config
  expansion, aliases, or defaults that make outcomes hard to predict.
- Redundant sources of truth, duplicated provenance, or consistency triangles.
- Misplaced code: domain behavior in CLI modules, parser files, docs examples,
  or compatibility wrappers.
- Vague concepts hardcoded into product logic, especially arbitrary tags,
  quality labels, modes, or special cases without a clear contract.
- Stale names and stale modules after refactors.
- Small files with no real ownership, and god modules that mix unrelated work.
- Backward-compatibility scaffolding that makes the current design worse.
- Docs, examples, smoke tests, CI, and PR descriptions that lag the code.

## Review Standard

- Prefer high-conviction findings over nitpicks.
- Be harsh on bugs and unnecessary complexity, but precise about evidence.
- Do not optimize for backward compatibility by default.
- When a fix is obvious, state it plainly. When it is not obvious, give the
  decision options in plain English.
- For repeated bug classes, look for the deeper pattern causing them.
- Keep "fresh eyes": do not only search for the last kind of bug found.
- A good finding explains what is wrong, why it matters, and the cleaner shape.

## Severity Scale

Use `P0` through `P4` for review findings:

- `P0 Critical`: security issue, data loss/corruption, broken main workflow,
  cannot ship or merge.
- `P1 High`: likely correctness bug, serious regression, broken CI/release gate,
  stale import after deletion, or major design flaw that will cause wrong output.
- `P2 Medium`: maintainability or design issue that is not immediately breaking
  but will make the system harder to evolve, debug, test, or reason about.
- `P3 Low`: localized cleanup, naming, docs drift, missing small test, weak
  docstring, or minor inconsistency worth fixing when already touching the area.
- `P4 Nit`: style, wording, tiny preference, or optional polish. Do not spend
  much review budget here unless the user asks for exhaustive polish.

Use severity for impact, not effort. A one-line fix can be `P1`; a big refactor
can be `P3` if nothing important is currently at risk.

## Output

Start with findings ordered by severity. Each finding should include:

- a short 1-3 word issue name, such as `Bad config names`
- severity from the `P0`-`P4` scale
- file/line evidence when available
- what is wrong
- why it matters
- the simpler or more correct fix
- the missing test/check if one should exist
- `Fix`: whether the fix is obvious or needs a user decision

Then include:

- `Checks`: what was run, what was not run, and what should be automated.
- `Docs`: stale or missing docs only if relevant.
- `Merge readiness`: direct verdict when the user asks whether it is ready.

For obvious fixes, say `Fix: Obvious` and name the concrete change. For
tradeoffs, say `Fix: Decision needed` and give concise labeled options so the
user can respond by issue name:

```text
Bad config names
Severity: Medium
Evidence: path/to/file.py:42
Problem: ...
Why it matters: ...
Fix: Decision needed
Option A: Rename the config keys to match the public CLI.
Option B: Keep the existing names but add a translation layer.
Option C: Remove the config path and require explicit CLI flags.
```
