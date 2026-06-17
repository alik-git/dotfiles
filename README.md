# dotfiles

Personal dotfiles managed with `chezmoi`.

This repo keeps the shared home-directory state small, explicit, and machine-aware. Most files are applied into `$HOME`; machine differences come from local chezmoi data in `~/.config/chezmoi/chezmoi.toml`, reusable public profiles, and a small number of machine-local files such as encryption identities.
The canonical working repo is `~/.local/share/chezmoi`.

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
uv tool install worklogs workset quick-status veneer-py
```

Plain pip also works:

```bash
python -m pip install worklogs workset quick-status veneer-py
```

Configure repo aliases for worksets in `~/.config/workset/repos.toml`:

```toml
[workset]
root = "~/worksets"
date_prefix = true
timezone = "America/New_York"

[repos]
api = "~/repos/api"
web = "~/repos/web"
```

First successful example:

```bash
git clone git@github.com:your-org/api.git ~/repos/api
worklogs new api-refactor--plan --scope work
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

## Machine Data

- The only fact a machine declares about itself is `machine_name`, set in the
  local `~/.config/chezmoi/chezmoi.toml`.
- The machine inventory (`machines.yaml`, in the private repo) is the single
  source of truth for every other attribute (`machine_class`, `os_type`,
  `has_gui`, ...). Templates look up the current machine by `machine_name` and
  derive everything from its catalog entry.
- To set up a machine (done once, by hand — there is intentionally no
  auto-generator):
  1. Add an entry for it to `machines.yaml` (private).
  2. Put `machine_name` in its local config and ensure the age key is present:
     ```toml
     # ~/.config/chezmoi/chezmoi.toml
     [data]
     machine_name = "your-machine-name"
     ```
  Nothing else needs per-machine wiring.

## Shell Config

The shell config is built in layers, loaded most-general to most-specific so a
machine only creates the layers it needs:

```text
base      -> every machine            (public)
os        -> os_type, e.g. ubuntu     (public)
task      -> machine_class, e.g. work (public)
machine   -> this machine's additions (private, pulled in by machine_name)
secrets   -> this machine's secrets   (private, age-encrypted)
```

- `.bashrc`/`.zshrc` stay small: they source `base`, then the matching `os` and
  `task` layers, then the machine and secrets layers, each only if present.
- `base`/`os`/`task` use generic names and are public — safe to share. The
  `machine` and `secrets` layers live in the private repo, keyed by real
  `machine_name`, and are pulled into name-free `local.sh` / `local.secrets.sh`
  targets. No machine name appears in the public repo.
- Put new config in the machine layer first; promote it to `task`/`os`/`base`
  only once it's clearly a shared pattern.
- When an installer appends shell init to `~/.bashrc` (conda, nvm, rustup, ...),
  move those lines by hand into the right layer — shared init into
  `base.sh`, machine-only init into the private machine layer — then
  `chezmoi apply ~/.bashrc`. This is a once-per-tool manual step on purpose;
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
- [`dotfiles_private/dot_codex/README.md`](dotfiles_private/dot_codex/README.md)
- [`dotfiles_private/private_dot_ssh/README.md`](dotfiles_private/private_dot_ssh/README.md)
- [`backups/vscode-old/2026-04-04/README.md`](backups/vscode-old/2026-04-04/README.md)

## Notes

- The repo must not contain secrets.
- If `chezmoi status` is dirty but Git is clean, a live home-directory file was modified after apply.
