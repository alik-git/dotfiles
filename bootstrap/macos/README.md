# macOS Bootstrap

This folder contains manual bootstrap notes for setting up a new macOS machine.
These files are tracked in the dotfiles repo, but they are not managed into
`$HOME` by chezmoi and they are not run automatically by `chezmoi apply`.

## Machine Identity

Declare the machine's facts in the local chezmoi config
(`~/.config/chezmoi/chezmoi.toml`), which chezmoi loads at apply time. `os_type`
is auto-derived (macos), so you set:

```toml
[data]
machine_name  = "<your-macos-machine-name>"
machine_class = "work"   # work | personal
has_gui       = true
```

`chezmoi init` prompts for these. You may also record the machine in
`dotfiles_private/machines.reference.yaml` for your own inventory, but chezmoi
does not load that file — the local config is the source of truth.

## Package Plan

Install these only after reviewing the first `chezmoi diff`.

Recommended base tools:

- Homebrew
- `age`
- `pre-commit`
- `ripgrep`
- `fd`
- `jq`
- `tmux`
- `zellij`
- `nvm`

Optional or workflow-dependent tools:

- Miniconda or Miniforge
- VS Code command-line launcher, `code`
- `shpool`, if macOS support is wanted for the same workflow as Linux
- worklogs / quick-status CLIs, depending on their current install source

## Shell

macOS uses zsh as the default login shell. The dotfiles keep common shell
behavior in `~/.config/shell/` and use shell-specific wrappers for Bash and zsh
so aliases and helper functions do not drift.

## VS Code

Linux VS Code settings target `~/.config/Code/User/`.

macOS VS Code settings target:

```text
~/Library/Application Support/Code/User/
```

Both targets render from the shared files under `.chezmoitemplates/vscode/`.

## SSH

This machine uses a local GitHub key at:

```text
~/.ssh/id_ed25519_github
```

The managed SSH config includes the macOS Keychain settings only on macOS
machines (`.chezmoi.os == "darwin"`), so other machines can continue using their
own SSH authentication strategy.
