# dotfiles

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/) — shell,
editor, git, and Codex/Claude agent setup — plus a few small public workflow
CLIs. This page is how to adopt them. The canonical working copy lives at
`~/.local/share/chezmoi`.

## Quick start

Prerequisites: **chezmoi** (applies the dotfiles) and **[uv](https://docs.astral.sh/uv/)**
(Python environments and optional CLI tools). Conda is only needed by projects
that explicitly depend on it.

```bash
chezmoi init https://github.com/alik-git/dotfiles.git
cd ~/.local/share/chezmoi
chezmoi diff      # preview before applying
chezmoi apply
```

Not Ali / no access to the private companion repo? Fine — skip
`git submodule update` and you get the working public subset (private-backed
targets are simply omitted). With access, authenticate to GitHub first
(`gh auth login` — all git here uses HTTPS via `gh`), then run
`git submodule update --init --recursive` before `apply`.

chezmoi does **not** manage `~/.gitconfig` (it carries machine-local `gh`
credential helpers), so set your git identity once:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

## Updating an existing machine

The public source, private companion, and live dotfiles can each have local
changes. Inspect them before updating; a merged PR does not update any of them:

```bash
cd ~/.local/share/chezmoi && \
  git status --short && \
  git diff --submodule && \
  git submodule status
```

For an initialized private companion, inspect its own `git status` and `git diff`
as well. Preserve or reconcile local edits before fast-forwarding the public
checkout and updating the companion to the pinned revision. Authenticate with
`gh` if the companion has not been initialized; the public-only subset omits
private targets.

After reconciling the source, preview the intended targets with `chezmoi diff`,
then apply that same scope. Recheck it afterward. A whole-home apply is optional,
not part of every update. Machine-specific `[data]` and the age identity stay
local; do not copy another computer's configuration wholesale.

If chezmoi reports that its config template changed, review `.chezmoi.toml.tmpl`
and run `chezmoi init` to regenerate the local config from the existing answers.
Review the result before applying; this is separate from fetching source updates.


## Machine setup

`chezmoi init` prompts once for the few facts that can't be auto-detected and
writes them to `~/.config/chezmoi/chezmoi.toml` — the one place chezmoi reliably
loads at apply time:

```toml
[data]
machine_name  = "workstation"   # identity; selects this machine's private layer
machine_class = "work"          # work | personal  -> task shell layer
machine_role  = "workstation"   # workstation | compute -> installed reference scope
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

### Machine role

`machine_class` selects work or personal configuration. `machine_role` selects
full workstation references or short compute references at the same installed
`~/.agent_files/local/docs/{machines,resources}.md` paths. Both roles keep the
same development tools, skills, and access to private dotfiles. This controls
installed context, not repository permissions or credential access.

An unset role retains workstation behavior. Set `machine_role = "compute"` in
local `[data]` to opt in, then preview and apply only the reference documents.
Compute machines omit the workstation cloud-setup note; if already installed,
review and remove that old note explicitly because ignoring it does not delete it.

## Workflow tools

Install the usual helpers during bootstrap so they are available; their use is
optional for each task. `uv tool install` takes one package at a time:

```bash
uv tool install agent-chat-reader && \
  uv tool install quick-status && \
  uv tool install workset
```

For projects needing a Conda base, `uv tool install veneer-py` adds the veneer CLI.

- `agent-chat-reader`: prior Codex/Claude chat search and reading.
- `quick-status`: combined repository, CI, and environment snapshots.
- `workset`: groups Git worktrees for multi-repository changes; ordinary Git
  worktrees or existing checkouts are also fine. Its optional local repo map
  is `~/.config/workset/repos.toml`.
- `veneer-py`: the `veneer` CLI for projects needing a shared Conda base.
  Install Conda only when the project needs it; uv is the usual Python starting point.

See [workspace reference](private_dot_agent_files/docs/workspace-setup.md) for locations.

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
`private_dot_codex/` and `private_dot_agent_files/` provide the global Codex/Claude agent setup:
`~/.agent_files/AGENTS.md` is the source of truth, and `~/.codex/AGENTS.md` /
`~/.claude/CLAUDE.md` point to it. With the private companion installed, chezmoi
updates shared Codex settings without overwriting other settings.
See [browser setup](private_dot_codex/README.md).

Custom skills are standalone Git repos cloned into `~/.agents/skills/<name>`.
Codex discovers them there; link each installation into `~/.claude/skills/<name>`
for Claude. Update with ordinary Git. The private companion's
`bootstrap/skills.md` lists the repos to install. Plugin skills stay with their
plugin manager; dotfiles does not manage skill contents or links.

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
