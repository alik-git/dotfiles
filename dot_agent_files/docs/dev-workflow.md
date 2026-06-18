# Dev Workflow

The day-to-day loop with `worklogs`, `workset`, `quick-status`, and `veneer`.
These are public tools, so this works with or without the private companion repo.
One-time install and config (`~/.config/workset/repos.toml`, worklogs config)
live in the repo README; this doc is just the loop.

## Starting a task

Pick the right bucket — do NOT create a workset for read-only tasks. A worklog's
**scope** is its top-level bucket: `work` for work tasks, `personal` for tools
and personal notes.

**Read-only** (code review, investigation, PR check — most common):
```bash
worklogs new api-review--codereview --scope work
```

**Implement, discuss first** (dominant impl path — refine plan before coding):
```bash
worklogs new api-refactor--plan --scope work
# ... discuss and refine the plan ...
worklogs workset api-refactor api:feat/refactor web:main
```

**Implement, repos known upfront** (shortcut when scope is clear):
```bash
worklogs new checkout-flow--plan --scope work \
  --workset api:feat/checkout-flow \
  --workset web:main
```

`worklogs workset` finds the existing plan by slug and mirrors its path into a
workset (a directory of git worktrees, one per repo).

## Companion note discipline

Files land at `YYYY/MM-month/DD-ddd/HHMM-Xa--name--kind.md`
(e.g. `2026/06-june/15-mon/0143-1a--api-refactor--plan.md`).

Update the companion note (`...-note.md`) during execution — not just at the end:
- After each significant decision or finding
- When a phase completes or is skipped
- Before opening a PR (include the PR link)

The plan file IS updated during execution, but only for structural state:
- Mark phases done (✅), flip `status: open` → `done` when finished
- Record major direction changes or decisions that affect the plan itself

Do NOT use the plan as an execution log. Running notes, commands, failures, and
findings go in the companion note — not the plan.

## veneer — Python env for conda repos

Repos with conda deps carry a committed, self-contained `veneer.toml`:
```toml
[python]
base_conda_env = "my-conda-env"
venv = ".venv"

[editables]
packages = ["source/my_package"]
install_deps = false
```

The conda env name comes from your machine setup (see the repo's `veneer.toml`
comment). In a worktree, `veneer update-editables` sets up the venv, then
`veneer python <anything>` runs in it. `workset` cross-installs every repo's
editables into each veneer venv, so any repo in the workset is importable from
any of its venvs. Pure-Python repos have no `veneer.toml` — uv handles them and
`workset` cross-installs their source too.

## Search

```bash
worklogs find "api-refactor"   # full-text search across all worklog files
```
