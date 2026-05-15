---
name: ali-code-review
description: "Review code with Ali's senior-engineer standard: identify the problem being solved, judge whether the solution is simple and first-principles, and flag correctness bugs, bad abstractions, stale code, poor readability, docs drift, and unnecessary compatibility scaffolding."
---

# Ali Code Review

Review like a fresh senior engineer reading the code for the first time. Assume
the authors are competent, then look for what is still clearly wrong, fragile,
stale, overcomplicated, misplaced, or awkward enough to fix before review or
merge.

The central question is:

```text
What problem is this code trying to solve, and is this the simplest clean
first-principles solution to that problem?
```

Do not start with formatter/linter trivia. Start by understanding the problem,
the ideal solution, and whether the implementation solves it with correctness,
low complexity, clear ownership, and readable code.

## Mode Selection

Use **Normal Review** by default for PRs, diffs, recent changes, and
merge-readiness checks.

Use **First-Principles Review** for broad architecture review, repo
simplification, redesign, repeated-refactor diagnosis, or "this works; now make
it good."

Normal Review can still include design findings. First-Principles Review goes
deeper: identify the problem, compare the current design against the ideal simple
solution, and explain how to get there.

## Professional-Quality Questions

For any nontrivial review, ask these early:

1. **Problem fit**: What problem is the code solving? Is the problem real,
   current, and clear enough that the solution can be judged?
2. **Simplest shape**: What would the lean first-principles solution look like?
   Is the current code close to that, or is it carrying accidental complexity?
3. **Normal workflow**: What path should users or callers actually follow? Is it
   explicit, boring, documented, and not hidden behind incidental scripts or
   magic?
4. **Core concepts**: What concepts does the repo actually need? Are they named
   honestly and represented directly in code?
5. **Source of truth**: Where is each important rule or decision made? Are
   multiple places making the same decision differently?
6. **Meaning vs support**: Which code defines domain meaning, and which code is
   support machinery such as scripts, adapters, logging, dashboards, metrics,
   debug tools, CI, or external integrations?
7. **State and evidence**: If the workflow produces durable results, generated
   files, caches, checkpoints, logs, or external side effects, is it clear what
   happened, what inputs/configs were used, and when results are stale?
8. **Deletion**: What can be removed, inlined, renamed, or made explicit instead
   of preserved as compatibility scaffolding?
9. **Readability**: Would a strong engineer enjoy reading the file top to bottom?
   Is the main flow obvious, or is it a hodgepodge of helpers and old ideas?
10. **Executable contract**: What test, smoke check, lint rule, import check, or
    docs check would catch this class of problem next time?

A good review finding usually comes from one of these questions.

## Review Flow

1. Define the boundary: PR, branch, diff, commit range, feature, or whole repo.
   Do not silently narrow a whole-repo review.
2. Inspect actual code, docs, tests, config, examples, and command/API surface.
   Do not rely on memory for volatile repo state.
3. Identify the problem and workflow before judging implementation.
4. Review correctness, simplicity, design boundaries, readability, tests, docs,
   and automation.
5. Report high-conviction findings by severity. Be honest about residual risk
   and checks that were not run.

## First-Principles Review

For broad redesign or architecture review, do not start by proposing folders.
Start by comparing the current solution to the ideal solution for the actual
problem.

State the problem plainly:

```text
This repo/component is trying to let users do X, from inputs Y, under constraints
Z, producing outcome W.
```

Then describe the ideal lean solution:

- the few core concepts the repo actually needs;
- the normal lifecycle from user intent/input to final outcome;
- the public workflow users should follow;
- the state, resources, or external boundaries involved;
- the places where correctness can fail.

Use examples only as prompts, not assumed vocabulary:

- Web/API: request -> validation -> domain operation -> persistence -> response.
- CLI/tooling: args/config -> resolved action -> execution -> output/report.
- Research/ML: experiment intent -> config -> run -> logs/artifacts -> evaluation.
- Data system: input -> transform -> derived output -> validation -> use.
- Robotics/simulation: task/config -> environment setup -> control loop ->
  telemetry/reward/safety signal -> result.

If an important concept is unnamed, vague, or only implied by scattered code,
flag it. Unnamed concepts usually become duplicated logic.

When comparing current design to the ideal, look for:

- extra layers that do not solve a real problem;
- duplicated decisions or sources of truth;
- implicit stages hidden behind magic expansion or giant scripts;
- unclear identity, reuse, invalidation, or freshness rules;
- support tools that accidentally define domain behavior;
- external assumptions that are not validated at one boundary;
- missing evidence about what ran, failed, or produced an output.

The right fix might be a new abstraction, but it might also be deletion,
inlining, renaming, moving one rule to the right place, or making an implicit step
explicit.

## Readability and File Craft

Review whether each important file is satisfying to read from top to bottom.

A good source file should have a clear narrative:

1. module/package docstring or header explaining intent, behavior, and ownership;
2. imports and constants/configuration;
3. public API, main class, command handler, or primary workflow;
4. supporting helpers grouped near the code that uses them;
5. low-level utilities last, unless the language/convention suggests otherwise;
6. entrypoint boilerplate at the bottom when applicable.

This is not a rigid ordering rule. It is a readability test: a new reader should
understand the file's purpose, main flow, and supporting pieces without hunting
through a hodgepodge of unrelated functions.

Docstring expectations:

- Public modules, classes, and functions should explain purpose and behavior.
- One-line docstrings are fine for obvious functions.
- Complex functions need more than a one-liner when the algorithm, assumptions,
  side effects, invariants, failure modes, or call protocol are not obvious.
- A docstring should explain intent and behavior, not restate the name or
  signature.
- Comments should explain why code exists; if comments explain ordinary control
  flow, simplify the code or names.

Readable does not mean over-split or over-documented. A cohesive 300-line file
can be better than ten tiny files if the top-to-bottom flow is clear.

## What To Flag

Flag high-confidence issues such as:

- correctness bugs and edge cases likely to produce wrong output;
- solutions that are more complex than the problem requires;
- stale state, invalidation mistakes, unsafe reuse, or ambiguous selection;
- duplicated sources of truth;
- hidden behavior, silent fallbacks, implicit generation, or magic expansion;
- misplaced domain logic in scripts, parsers, examples, tests, or adapters;
- abstractions that do not own a real rule;
- important concepts that are unnamed or misleadingly named;
- stale names, modules, commands, docs, tests, or examples after refactors;
- compatibility scaffolding that makes the current design worse;
- missing tests for the actual contract;
- public surfaces that expose implementation details;
- files that are hard to read because their narrative/order is poor.

Do not spend much review budget on style nits unless the user asks for exhaustive
polish.

## Review Standard

Prefer high-conviction findings over nitpicks. Be harsh on bugs and unnecessary
complexity, but precise about evidence. For repeated bug classes, look for the
deeper pattern causing them. Keep fresh eyes: do not only search for the last
kind of bug found.

When a fix is obvious, state it plainly. When a fix needs a decision, give
concise labeled options. Do not recommend a new abstraction unless you can name
the problem it solves and the rule it owns. Do not preserve backwards
compatibility by default.

## Severity Scale

Use `P0` through `P4`:

- `P0 Critical`: security issue, data loss/corruption, broken main workflow, or
  cannot ship/merge.
- `P1 High`: likely correctness bug, serious regression, broken CI/release gate,
  stale import after deletion, or design flaw likely to cause wrong output.
- `P2 Medium`: design/maintainability issue that will make the system harder to
  evolve, debug, test, or reason about.
- `P3 Low`: localized cleanup, naming, docs drift, missing small test, weak docs,
  or minor inconsistency.
- `P4 Nit`: style, wording, tiny preference, or optional polish.

Use severity for impact, not effort. A one-line fix can be `P1`; a big refactor
can be `P3` if nothing important is currently at risk.

## Output

Start with numbered findings ordered by severity. Each finding should include:

```text
1. Short issue name
Severity: P1 High: Category
Evidence: file/line, command, test failure, observed behavior, or Not verified
Problem: What is wrong and why it matters.
Fix: Obvious - concrete change.
# or
Fix: Decision needed
Option A: ...
Option B: ...
Option C: ...
Recommended: # Option A or B or C ...
Missing test/check: ...
```

For tradeoffs, include as many useful options as needed; do not assume there are
only two.

After findings, include:

- `Checks`: what was run, what was not run, and what should be automated.
- `Docs`: stale or missing docs only if relevant.
- `Residual risk`: what might still be wrong because of missing context,
  unavailable dependencies, or unrun checks.
- `Merge readiness`: direct verdict when the user asks whether it is ready.

If there are no substantive findings, say so directly, then still include checks
and residual risk.

## Output for First-Principles Review

When using First-Principles Review, start with:

```text
Verdict

Problem being solved

Ideal first-principles solution

Current solution

Gap / root cause

Recommended target shape

What to delete or simplify

Migration plan

Validation plan

Findings
```

The comparison should be problem-oriented:

- What problem is the repo/component solving?
- What would the cleanest lean solution look like?
- How does the current design fall short?
- Why did it end up that way?
- What changes get it closest to the ideal with the least complexity?

Keep this section concise. It should clarify the architecture, not bury the user
in a speculative design essay.

## Basic Gates

Check these after the higher-level review, not before it:

- formatting, linting, typing/imports;
- dead code, stale imports, abandoned entrypoints;
- tests, smoke tests, golden examples, regression tests;
- docs drift, CLI/API drift, config drift;
- generated/local files that should not be tracked.

If a repeated failure mode lacks an automated check, flag that.

## Honesty Rules

Be explicit about what you inspected and did not inspect. Do not claim tests
passed unless you ran them or have direct evidence. Do not claim a design is good
just because it is cleaner than before. If the right fix requires a product or
research decision, present the decision.
