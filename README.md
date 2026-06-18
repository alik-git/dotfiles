# dotfiles

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/) — shell,
editor, git, and Codex/Claude agent setup — plus a few small public workflow
CLIs. This page is how to adopt them. The canonical working copy lives at
`~/.local/share/chezmoi`.

## Quick start

Prerequisites: **chezmoi** (applies the dotfiles) and **[uv](https://docs.astral.sh/uv/)**
(installs the CLIs — `curl -LsSf https://astral.sh/uv/install.sh | sh`, or use
`pip`). `veneer` additionally needs Miniconda/conda; the other CLIs don't.

```bash
chezmoi init git@github.com:alik-git/dotfiles.git
cd ~/.local/share/chezmoi
chezmoi diff      # preview before applying
chezmoi apply
```

Not Ali / no access to the private companion repo? Fine — skip
`git submodule update` and you get the working public subset (private-backed
targets are simply omitted). With access, run
`git submodule update --init --recursive` before `apply`.

chezmoi does **not** manage `~/.gitconfig` (it carries machine-local `gh`
credential helpers), so set your git identity once:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

Update later with `git pull && chezmoi diff && chezmoi apply` (prefix
`git submodule update --init --recursive &&` if you have the private repo).

## Machine setup

`chezmoi init` prompts once for the few facts that can't be auto-detected and
writes them to `~/.config/chezmoi/chezmoi.toml` — the one place chezmoi reliably
loads at apply time:

```toml
[data]
machine_name  = "workstation"   # identity; selects this machine's private layer
machine_class = "work"          # work | personal  -> task shell layer
has_gui       = false           # gate GUI-only targets (VS Code, Nautilus)
```

The OS is auto-detected (you don't declare it). To configure by hand instead, just
write that block yourself; with the private repo + encrypted secrets, also add:

```toml
encryption = "age"
[age]
    identity = "~/.config/chezmoi/key.txt"
    recipient = "<your age recipient>"
```

(`dotfiles_private/machines.reference.yaml` is only a human inventory — chezmoi
does not load it; this local config is the source of truth.)

## Workflow CLIs

A few small, public command-line tools, all installable with uv (or `pip`):

```bash
uv tool install worklogs workset quick-status veneer-py agent-chat-reader
```

- **`worklogs`** — create dated worklog notes/plans (and the worksets that mirror them).
- **`workset`** — make a **workset**: a directory of git worktrees for one task.
- **`veneer`** — per-worktree Python env: a thin venv "veneer" over a shared conda base.
- **`quick-status`** (`qs`) — one-shot snapshot of repo, worktree, CI, and env state.
- **`agent-chat-reader`** — read and search past Codex & Claude CLI history.

`workset` reads `~/.config/workset/repos.toml`, which maps a short name to a
**local clone you've already made**. It isn't shipped (it points at your own
paths), so create it — `api`/`web` here are placeholders:

```toml
[workset]
root = "~/worksets"
date_prefix = true
timezone = "America/New_York"

[repos]
api = "~/repos/api"   # placeholder: your short-name = local clone path
web = "~/repos/web"
```

`worklogs` reads `~/.config/worklogs/config.toml` (chezmoi ships an editable
default — `root`, `default_scope`, `timezone`, `worksets_root`). A worklog's
**scope** is just its top-level bucket, e.g. `personal` or `work`.

First run (replace the `your-org`/`api` placeholders; match `--scope` to your
`default_scope`):

```bash
git clone git@github.com:your-org/api.git ~/repos/api
worklogs new api-refactor--plan --scope personal
worklogs workset api-refactor api:feat/refactor
```

For the day-to-day loop, see `~/.agent_files/docs/dev-workflow.md` (applied by
chezmoi).

## How it works

Most files apply into `$HOME`; per-machine differences come from the local
`~/.config/chezmoi/chezmoi.toml` data plus a few machine-local files (like the
age identity). The repo is **public**; a private `dotfiles_private` submodule
holds machine-specific and secret content. Public targets that need private
content are thin templates that include from the submodule and degrade to
no-ops when it's absent — so the public subset stands on its own.

### Shell config

Layers load most-general to most-specific, each only if present:

```text
shared  -> ~/.config/shell/* : aliases, PATH/env, and the task/machine/secrets
                               layers, loaded by both bash and zsh, every machine
base    -> ~/.config/bash/base.sh : bash-only init (conda/nvm)
task    -> machine_class (work)        (public, in the shared tree)
machine -> this machine's additions    (private, by machine_name)
secrets -> this machine's secrets       (private, age-encrypted)
```

- The shared tree is public and cross-shell; `machine`/`secrets` come from the
  private repo (keyed by `machine_name`, rendered into name-free `local.sh` /
  `local.secrets.sh`) — no machine name appears in the public repo.
- Put new config in the machine layer first; promote to `task`/shared only once
  it's clearly a shared pattern.
- When an installer appends init to `~/.bashrc`, move it by hand into the right
  layer — cross-shell → `~/.config/shell/shared.sh`, bash-only tool init →
  `~/.config/bash/base.sh`, machine-only → the private layer — then
  `chezmoi apply ~/.bashrc`.

## Reference

### Private files & secrets
Private tracked files live in the `dotfiles_private` submodule; public targets
that need them are thin templates that include from it. The public-repo privacy
denylist is `dotfiles_private/privacy/denylist.tsv`. Machine secrets are
`age`-encrypted; the age identity is machine-local and lives outside the repo.

### Privacy checks
Two `pre-commit` checks guard the public repo (install with
`pre-commit install --hook-type pre-commit --hook-type pre-push`):

- `gitleaks-system` — common secrets in staged content.
- `scripts/privacy_check.py` — dotfiles-specific private context via the
  denylist; it no-ops without the private repo, so it won't block a colleague.
  Full manual run: `python3 scripts/privacy_check.py --history`.

### Codex / agent files
`dot_codex/` and `dot_agent_files/` provide the global Codex/Claude agent setup:
`~/.agent_files/AGENTS.md` is the source of truth, and `~/.codex/AGENTS.md` /
`~/.claude/CLAUDE.md` point to it. `~/.codex/config.toml` is managed from the
private repo (absent on public-only clones); Codex rewrites parts of it at
runtime, so expect `chezmoi diff` to show drift there.

### Bootstrap
`bootstrap/` is tracked reference material (not applied): `linux/`, `macos/`,
`nas/`, `nautilus/`.

### Notes
- The repo must not contain secrets.
- If `chezmoi status` is dirty but Git is clean, a live file was edited after apply.

### Further reading
- [`bootstrap/linux/README.md`](bootstrap/linux/README.md) · [`macos`](bootstrap/macos/README.md) · [`nas`](bootstrap/nas/README.md) · [`nautilus`](bootstrap/nautilus/README.md)
- [`dot_config/Code/User/README.md`](dot_config/Code/User/README.md)
- [`dotfiles_private/README.md`](dotfiles_private/README.md) (private)
