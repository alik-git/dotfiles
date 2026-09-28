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

## Tools

Install what is missing for the work at hand. The usual basics are Homebrew,
chezmoi, GitHub CLI (`gh`), uv, and ripgrep. `age` is needed to apply encrypted
private files. `pre-commit` and gitleaks support this repository's checks.

`tmux`, `zellij`, Node tooling, editor launchers, and workflow CLIs are optional.
Conda/Miniforge and veneer are for projects that need their environment model;
they are not prerequisites for ordinary uv projects.

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

## GitHub auth

Git uses HTTPS via the `gh` CLI: run `gh auth login` once and `gh auth
setup-git` wires the credential helper into `~/.gitconfig`. No SSH key is needed
for GitHub.

A local SSH key (`~/.ssh/id_ed25519_github`) is kept for any non-GitHub SSH
hosts; it is no longer used for git.
