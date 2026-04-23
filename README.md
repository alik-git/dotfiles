# dotfiles

Personal dotfiles managed with `chezmoi`.

This repo keeps the shared home-directory state small, explicit, and machine-aware. Most files are applied into `$HOME`; machine differences come from `~/.config/chezmoi/chezmoi.toml`, tracked machine metadata in `.chezmoidata/`, and a small number of machine-local files such as encryption identities.
The canonical working repo is `~/.local/share/chezmoi`.

## Installation

```bash
chezmoi init git@github.com:alik-git/dotfiles.git
cd ~/.local/share/chezmoi
git submodule update --init --recursive
chezmoi diff
chezmoi apply
```

Set up GitHub SSH first. The private companion repo is a Git submodule cloned over SSH.

If needed, do machine-local follow-up after apply for tools not yet represented in the dotfiles.

For normal updates:

```bash
cd ~/.local/share/chezmoi
git pull
git submodule update --init --recursive
chezmoi diff
chezmoi apply
```

## Private Files

- Private tracked files currently live in the `dotfiles_private` Git submodule.
- Private machine-managed targets in the main repo are thin templates that include content from `dotfiles_private`.
- Non-managed private reference material, such as the NAS private README, lives directly in `dotfiles_private`.
- Machine shell secrets can be tracked in encrypted form with `age`.
- The local age identity is machine-local and lives outside the repo.

## Machine Data

- Local selector: `~/.config/chezmoi/chezmoi.toml`
- Tracked machine catalog: `.chezmoidata/machines.yaml`
- Machine metadata controls per-machine behavior such as whether Nautilus scripts should be applied.

## Shell Config

- The main `.bashrc` is intentionally small.
- It sources shared shell setup, the shared prompt, a tracked machine `personal` file, a tracked machine `auto` file, and an optional machine `secrets` file.
- `personal` is for manual machine-specific shell config.
- `auto` is for tool-managed or machine-specific init such as `conda` or `nvm`.
- `secrets` may be tracked in encrypted form with `age`; the live plaintext target remains local in `$HOME`.
- If a program appends shell init to `.bashrc`, use `chezmoi-mv-bashrc-diff` to preview it and `chezmoi-mv-bashrc` to move it into the tracked machine `auto` file and restore the clean managed `.bashrc`.
- These helpers are bash-specific. Supporting zsh or other shells would need parallel shell-specific files and helpers.

## Codex Files

- `dot_codex/` contains the managed global Codex `AGENTS.md`, `config.toml`, and rules.
- `dot_agent_files/` contains the managed `~/.agent_files/...` targets used by the global Codex setup.
- Some `dot_agent_files/` targets are thin templates that include content from `dotfiles_private`.
- Keep in mind that Codex programmatically adds some live config on startup.
- In particular, trusted project paths and `model_reasoning_effort` may appear in the live `~/.codex/config.toml` even when they are not present in the chezmoi source.

## Bootstrap Material

- `bootstrap/` is tracked reference material, not home-directory state applied by chezmoi.
- `bootstrap/linux/` contains Linux bootstrap helpers.
- `bootstrap/nas/` contains NAS setup reference files.
- `bootstrap/nautilus/` documents the Nautilus copy-path scripts.

## Further Reading

If you need more context, these READMEs cover narrower parts of the setup:

- [`bootstrap/linux/README.md`](bootstrap/linux/README.md)
- [`bootstrap/nas/README.md`](bootstrap/nas/README.md)
- [`bootstrap/nautilus/README.md`](bootstrap/nautilus/README.md)
- [`dot_config/Code/User/README.md`](dot_config/Code/User/README.md)
- [`dotfiles_private/README.md`](dotfiles_private/README.md)
- [`dotfiles_private/bootstrap/nas/README.private.md`](dotfiles_private/bootstrap/nas/README.private.md)
- [`dotfiles_private/dot_codex/README.md`](dotfiles_private/dot_codex/README.md)
- [`dotfiles_private/private_dot_ssh/README.md`](dotfiles_private/private_dot_ssh/README.md)
- [`backups/vscode-old/2026-04-04/README.md`](backups/vscode-old/2026-04-04/README.md)

## Notes

- `DEVLOG.md` is local-only context and is intentionally not committed.
- The repo must not contain secrets.
- If `chezmoi status` is dirty but Git is clean, a live home-directory file was modified after apply.
