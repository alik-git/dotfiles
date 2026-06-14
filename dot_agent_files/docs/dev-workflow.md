# Dev Workflow

Tools: `worklogs`, `workset`, `veneer`. All installed via `uv tool install`.

## Starting a task

Pick the right bucket — do NOT create a workset for read-only tasks:

**Read-only** (code review, investigation, PR check — most common):
```bash
worklogs new pr82-review--codereview --scope work --project my-project
```

**Implement, discuss first** (dominant impl path — refine plan before coding):
```bash
worklogs new leansim2sim--plan --scope work --project my-project
# ... discuss and refine the plan ...
worklogs workset leansim2sim my-repo:feat/my-feature my-other-repo:main
```

**Implement, repos known upfront** (shortcut when scope is clear):
```bash
worklogs new improve-viewer--plan --scope work --project my-project \
  --workset my-repo:feat/my-feature
```

Scope is `work` for work tasks, `personal` for tools and personal notes.
`worklogs workset` finds the existing plan by slug and mirrors the path.

## Companion note discipline

Update `HHMM--name--note.md` during execution — not just at the end:
- After each significant decision or finding
- When a phase completes or is skipped
- Before opening a PR (include the PR link)

The plan file IS updated during execution, but only for structural state:
- Mark phases done (✅), update `status: open` → `done` when finished
- Record major direction changes or decisions that affect the plan itself

Do NOT use the plan as an execution log. Running notes, commands, failures,
and findings go in the companion note — not the plan.

## veneer — Python env for conda repos

Repos with conda deps have a committed self-contained `veneer.toml`:
```toml
[python]
base_conda_env = "my-conda-env"
venv = ".venv"

[editables]
packages = ["source/my_package"]
install_deps = false
```

The conda env name comes from your machine setup. Check `~/.config/workset/repos.toml` or the repo`s veneer.toml comment for the right name.

In a worktree: `veneer update-editables` sets up the venv.
Then: `veneer python <anything>`.

`workset` cross-installs all repos' editables into each veneer venv automatically
so every repo in the workset is importable from any veneer venv.

Pure-Python repos (e.g. `my-pure-python-repo`) have no veneer.toml — uv handles
them and their source is cross-installed into veneer venvs by workset.

## Config files

```
~/.config/workset/repos.toml    # short name → canonical repo path mapping
~/.config/worklogs/config.toml  # default scope, worksets_root, timezone
```

## Search

```bash
worklogs find "sim2sim"   # full-text search across all worklog files
```
