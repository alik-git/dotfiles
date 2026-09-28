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

Bootstrap is a one-time setup: install the recommended tools so they are ready
when useful. Having a tool installed does not require agents to use it for any
particular task.

Recommended base tools:

- Homebrew
- chezmoi
- GitHub CLI (`gh`)
- uv
- `age`
- `pre-commit` and gitleaks
- `ripgrep`
- `fd`
- `jq`
- `tmux`
- `zellij`
- `nvm`
- `agent-chat-reader`, `quick-status`, and `workset` (see the root README)

Optional or workflow-dependent tools:

- Miniconda or Miniforge, plus `veneer-py`, for projects needing a Conda base
- VS Code command-line launcher, `code`, when VS Code is installed
- `shpool`, if supported and useful on the target machine

uv is the usual Python starting point. Conda and veneer remain available for
projects that need them; the repository's environment configuration determines
which to use.

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
