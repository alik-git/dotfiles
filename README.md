# dotfiles

Personal dotfiles managed with `chezmoi`.

This repo keeps the shared home-directory state small, explicit, and machine-aware. Most files are applied into `$HOME`; machine differences come from `~/.config/chezmoi/chezmoi.toml`, tracked machine metadata in `.chezmoidata/`, and a small number of local-only files such as shell secrets.
The canonical working repo is `~/.local/share/chezmoi`.

## Installation

```bash
chezmoi init git@github.com:alik-git/dotfiles.git
chezmoi diff
chezmoi apply
```

If needed, do machine-local follow-up after apply, for example `conda init bash`.

For normal updates:

```bash
cd ~/.local/share/chezmoi
git pull
chezmoi diff
chezmoi apply
```

## Machine Data

- Local selector: `~/.config/chezmoi/chezmoi.toml`
- Tracked machine catalog: `.chezmoidata/machines.yaml`
- Machine metadata controls per-machine behavior such as whether Nautilus scripts should be applied.

## Shell Config

- The main `.bashrc` is intentionally small.
- It sources shared shell setup, the shared prompt, a tracked machine `personal` file, a tracked machine `auto` file, and an optional local-only machine `secrets` file.
- `personal` is for manual machine-specific shell config.
- `auto` is for tool-managed or machine-specific init such as `conda` or `nvm`.
- `secrets` is local-only, ignored by Git, and must never be committed.
- If a program appends shell init to `.bashrc`, use `chezmoi-mv-bashrc-diff` to preview it and `chezmoi-mv-bashrc` to move it into the tracked machine `auto` file and restore the clean managed `.bashrc`.
- These helpers are bash-specific. Supporting zsh or other shells would need parallel shell-specific files and helpers.

## Codex Files

- `dot_codex/` contains the managed global Codex `AGENTS.md`, `config.toml`, and rules.
- The rules file is intended to stay small and only allow broadly safe commands.

## Bootstrap Material

- `bootstrap/` is tracked reference material, not home-directory state applied by chezmoi.
- `bootstrap/linux/` contains Linux bootstrap helpers.
- `bootstrap/nas/` contains NAS setup reference files.
- `bootstrap/nautilus/` documents the Nautilus copy-path scripts.

## Notes

- `DEVLOG.md` is local-only context and is intentionally not committed.
- The repo must not contain secrets.
- If `chezmoi status` is dirty but Git is clean, a live home-directory file was modified after apply.
