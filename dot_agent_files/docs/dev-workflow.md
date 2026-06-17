# Dev Workflow

Tools: `worklogs`, `workset`, `quick-status`, `veneer`.

See `~/.local/share/chezmoi/README.md` for install instructions.

## Starting a task

Pick the right bucket — do NOT create a workset for read-only tasks:

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

Scope is `work` for work tasks, `personal` for tools and personal notes.
`worklogs workset` finds the existing plan by slug and mirrors the path.

## Companion note discipline

Files land at `YYYY/MM-month/DD-ddd/HHMM-Xa--name--kind.md`
(e.g. `2026/06-june/15-mon/0143-1a--api-refactor--plan.md`).
`worklogs workset <slug>` finds the plan by slug and mirrors the workset path.

Update the companion note (`...-note.md`) during execution — not just at the end:
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

The conda env name comes from your machine setup. Check `~/.config/workset/repos.toml` or the repo's `veneer.toml` comment for the right name.

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

Minimal `~/.config/workset/repos.toml`:

```toml
[workset]
root = "~/worksets"
date_prefix = true
timezone = "America/New_York"

[repos]
api = "~/repos/api"
web = "~/repos/web"
```

First successful setup:

```bash
git clone git@github.com:your-org/api.git ~/repos/api
worklogs new api-refactor--plan --scope work
worklogs workset api-refactor api:feat/refactor
```

## Search

```bash
worklogs find "api-refactor"   # full-text search across all worklog files
```
