# dotfiles

Personal dotfiles managed with `chezmoi`.

## What Lives Here

This repo has two kinds of content:

1. Managed home-directory files, using normal chezmoi naming like `dot_bashrc`, `dot_codex/...`, and `dot_local/...`.
2. Tracked bootstrap/reference material under `bootstrap/`, which is kept in Git but ignored by chezmoi as a target to apply into `$HOME`.

Current managed areas:

- Bash config and custom prompt
- Codex `AGENTS.md`, `config.toml`, and rules
- Nautilus copy-path scripts

Current bootstrap/reference areas:

- `bootstrap/linux/`: manual Linux machine bootstrap helpers
- `bootstrap/nas/`: NAS setup reference
- `bootstrap/nautilus/`: notes for the Nautilus scripts

## Machine Data

Machine-specific data is split like this:

- Local-only selector: `~/.config/chezmoi/chezmoi.toml`
- Tracked machine catalog: `.chezmoidata/machines.yaml`

Right now the local config just selects the machine name, for example:

```toml
[data]
machine_name = "white_xps"
```

## Normal Workflow

On a new machine:

```bash
chezmoi init git@github.com:alik-git/dotfiles.git
chezmoi diff
chezmoi apply
```

If needed, then do machine-local follow-up such as `conda init bash`.

For shared changes:

```bash
cd ~/.local/share/chezmoi
git pull
chezmoi diff
chezmoi apply
```

## Notes

- `DEVLOG.md` is local-only context and is intentionally not committed.
- The repo should not contain secrets.
- If `chezmoi status` is dirty but Git is clean, that usually means a live home-directory file was modified after apply.
