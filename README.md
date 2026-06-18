# dotfiles

Personal dotfiles managed with `chezmoi`.

This repo keeps the shared home-directory state small, explicit, and machine-aware. Most files are applied into `$HOME`; machine differences come from local chezmoi data in `~/.config/chezmoi/chezmoi.toml`, reusable public profiles, and a small number of machine-local files such as encryption identities.
The canonical working repo is `~/.local/share/chezmoi`.

## Getting Started

New here? The short path:

1. Install chezmoi and apply this repo — [Installation](#installation).
2. Install the workflow CLIs — [Workflow Tools](#workflow-tools).
3. Declare this machine's config — [Machine Setup](#machine-setup).
4. Read `~/.agent_files/docs/dev-workflow.md` (applied by chezmoi) for the
   day-to-day task flow, then run the first-task example below.

The workflow CLIs (all public, installable via `uv tool install`):

- **`veneer`** (`veneer-py`) — per-worktree Python env manager for conda-based repos.
- **`workset`** — create isolated git-worktree worksets for a task.
- **`worklogs`** — create worklog plans/notes and worksets with mirrored paths.
- **`quick-status`** (`qs`) — fast snapshot of repo, worktree, CI, and env state.
- **`agent-chat-reader`** — read and search past Codex & Claude CLI chat history.

## Prerequisites

- **[chezmoi](https://www.chezmoi.io/install/)** — applies these dotfiles.
- **[uv](https://docs.astral.sh/uv/)** — installs the workflow CLIs:
  `curl -LsSf https://astral.sh/uv/install.sh | sh` (plain `pip` also works).
- **Miniconda/conda** — only needed if you use `veneer`, which overlays editable
  Python packages on a conda base env. Install Miniconda, then create your own
  env(s); each repo's `veneer.toml` names the env to use. `worklogs`, `workset`,
  `quick-status`, and `agent-chat-reader` need no conda.

## Installation

```bash
chezmoi init git@github.com:alik-git/dotfiles.git
cd ~/.local/share/chezmoi
chezmoi diff
chezmoi apply
```

If you do not have access to the private repo because you are not Ali, that is
fine; this repo should still work without it. If you do have access, initialize
the private companion repo before applying:

```bash
git submodule update --init --recursive
```

Without the private repo, skip the submodule step and use the public subset.
Private-backed templates or reference docs will be unavailable until you add
your own local equivalents.

If needed, do machine-local follow-up after apply for tools not yet represented in the dotfiles.

chezmoi does not manage `~/.gitconfig` (it carries machine-local `gh` credential
helpers), so set your own git identity once:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

For normal updates:

```bash
cd ~/.local/share/chezmoi
git pull
# Optional, only if the private companion repo is available to you:
git submodule update --init --recursive
chezmoi diff
chezmoi apply
```

## Workflow Tools

Install the shared workflow CLIs:

```bash
uv tool install worklogs workset quick-status veneer-py agent-chat-reader
```

Plain pip also works:

```bash
python -m pip install worklogs workset quick-status veneer-py agent-chat-reader
```

Configure repo aliases for worksets in `~/.config/workset/repos.toml`. This file
isn't shipped (it points at your own local clones), so create it yourself. The
`[repos]` entries map a short name to a **local clone you've already made** —
`api`/`web` below are placeholders, replace them with your own:

```toml
[workset]
root = "~/worksets"
date_prefix = true
timezone = "America/New_York"

[repos]
api = "~/repos/api"   # placeholder: your real short-name = local clone path
web = "~/repos/web"
```

`worklogs` reads `~/.config/worklogs/config.toml` (chezmoi applies a generic
default — `root`, `default_scope`, `timezone`, `worksets_root` — edit it to
taste). With the private companion repo, your own config is used instead.

First successful example (replace the `your-org`/`api` placeholders with real
values; the `--scope` should match your config's `default_scope`):

```bash
git clone git@github.com:your-org/api.git ~/repos/api
worklogs new api-refactor--plan --scope personal
worklogs workset api-refactor api:feat/refactor
```

See `~/.agent_files/docs/dev-workflow.md` after applying chezmoi for the compact
day-to-day workflow.

## Private Files

- Private tracked files currently live in the `dotfiles_private` Git submodule.
- Private machine-managed targets in the main repo are thin templates that include content from `dotfiles_private`.
- Non-managed private reference material, such as the NAS private README, lives directly in `dotfiles_private`.
- Public-repo privacy denylist patterns live in `dotfiles_private/privacy/denylist.tsv`.
- Machine shell secrets can be tracked in encrypted form with `age`.
- The local age identity is machine-local and lives outside the repo.

## Privacy Checks

This public repo uses `pre-commit` for two privacy checks:

- `gitleaks-system` catches common secrets in staged content.
- `scripts/privacy_check.py` catches dotfiles-specific private context using the
  private denylist in `dotfiles_private/privacy/denylist.tsv`.

Install local hooks after cloning:

```bash
pre-commit install --hook-type pre-commit --hook-type pre-push
```

Run the full local check manually:

```bash
python3 scripts/privacy_check.py --history
```

## Machine Setup

Each machine identifies itself through its local chezmoi config
(`~/.config/chezmoi/chezmoi.toml`) — the one place chezmoi reliably loads at
apply time. It declares the few facts that can't be auto-detected:

```toml
[data]
machine_name  = "workstation"   # identity; selects this machine's private layer
machine_class = "work"          # work | personal  -> task shell layer
has_gui       = false           # gate GUI-only targets (VS Code, Nautilus)
```

`os_type` (ubuntu/macos) is derived automatically from chezmoi's OS detection,
so it is not declared.

- **(a) Automatic (recommended):** `chezmoi init` prompts for these once and
  writes the config for you. If your age key (`~/.config/chezmoi/key.txt`) is
  present, it also configures age encryption. Your answers are remembered.
- **(b) Manual / fallback:** if the prompts aren't what you want, just write the
  block above into `~/.config/chezmoi/chezmoi.toml` by hand. With the private
  repo and encrypted secrets, also add:
  ```toml
  encryption = "age"
  [age]
      identity = "~/.config/chezmoi/key.txt"
      recipient = "<your age recipient>"
  ```

`dotfiles_private/machines.reference.yaml` is only a human inventory of machines
— chezmoi does **not** load it (it can't load a private catalog at apply time),
so the local config is the real source of truth.

## Shell Config

The shell config is built in layers, loaded most-general to most-specific so a
machine only creates the layers it needs:

```text
shared  -> ~/.config/shell/* : aliases, PATH/env, and the task/machine/secrets
                               layers, loaded by both bash and zsh, every machine
base    -> ~/.config/bash/base.sh : bash-only init such as conda/nvm  (bash only)
task    -> machine_class (work)            (public, in the shared tree)
machine -> this machine's additions        (private, pulled in by machine_name)
secrets -> this machine's secrets          (private, age-encrypted)
```

- The shared layer lives under `~/.config/shell/` and is loaded by both bash and
  zsh on every machine; `base` is bash-specific (conda/nvm) under
  `~/.config/bash/`. Layers load most-general to most-specific, each only if
  present.
- `task` and the shared tree use generic names and are public — safe to share.
  The `machine` and `secrets` layers live in the private repo, keyed by real
  `machine_name`, and are pulled into name-free `local.sh` / `local.secrets.sh`
  targets. No machine name appears in the public repo.
- Put new config in the machine layer first; promote it to `task` or the shared
  tree only once it's clearly a shared pattern.
- When an installer appends shell init to `~/.bashrc` (conda, nvm, rustup, ...),
  move those lines by hand into the right layer — cross-shell init into the
  shared tree (`~/.config/shell/shared.sh`), bash-only tool init into
  `~/.config/bash/base.sh`, machine-only init into the private machine layer —
  then `chezmoi apply ~/.bashrc`. This is a once-per-tool manual step on purpose;
  there is no machinery that tries to relocate it automatically.
- `secrets` is tracked age-encrypted in the private repo; the live plaintext
  target is local-only with restrictive permissions. To change a secret,
  decrypt → edit → re-encrypt the private age file (see `jira-rest`'s error
  output for the exact command).

## Codex Files

- `dot_codex/` contains the managed global Codex `AGENTS.md`, `config.toml`, and rules.
- `dot_agent_files/` contains the managed `~/.agent_files/...` targets used by the global Codex setup.
- Some `dot_agent_files/` targets are thin templates that include content from `dotfiles_private`.
- Keep in mind that Codex programmatically adds some live config on startup.
- In particular, trusted project paths and `model_reasoning_effort` may appear in the live `~/.codex/config.toml` even when they are not present in the chezmoi source.

## Bootstrap Material

- `bootstrap/` is tracked reference material, not home-directory state applied by chezmoi.
- `bootstrap/linux/` contains Linux bootstrap helpers.
- `bootstrap/macos/` contains macOS bootstrap helpers.
- `bootstrap/nas/` contains NAS setup reference files.
- `bootstrap/nautilus/` documents the Nautilus copy-path scripts.

## Further Reading

If you need more context, these READMEs cover narrower parts of the setup:

- [`bootstrap/linux/README.md`](bootstrap/linux/README.md)
- [`bootstrap/macos/README.md`](bootstrap/macos/README.md)
- [`bootstrap/nas/README.md`](bootstrap/nas/README.md)
- [`bootstrap/nautilus/README.md`](bootstrap/nautilus/README.md)
- [`dot_config/Code/User/README.md`](dot_config/Code/User/README.md)
- [`dotfiles_private/README.md`](dotfiles_private/README.md)
- [`dotfiles_private/bootstrap/nas/README.private.md`](dotfiles_private/bootstrap/nas/README.private.md)
- [`dotfiles_private/private_dot_ssh/README.md`](dotfiles_private/private_dot_ssh/README.md)

## Notes

- The repo must not contain secrets.
- If `chezmoi status` is dirty but Git is clean, a live home-directory file was modified after apply.
