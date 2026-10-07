# Remote Codex update skill

[update-remote-codex](https://github.com/alik-git/update-remote-codex) is a public,
general skill for updating Codex on an existing remote host and verifying
reconnection. It has no machine-specific configuration or bundled credentials.

Keep its source in a standalone clone, like the other custom skills. This recipe
is reference material; chezmoi does not apply or automatically update the clone.

For a new installation, check that neither destination already exists. If one
does, inspect it and preserve local edits before deciding how to proceed.

```sh
cd "$HOME" && \
test ! -e "$HOME/.agents/skills/update-remote-codex" && \
test ! -L "$HOME/.agents/skills/update-remote-codex" && \
test ! -e "$HOME/.claude/skills/update-remote-codex" && \
test ! -L "$HOME/.claude/skills/update-remote-codex" && \
mkdir -p "$HOME/.agents/skills" "$HOME/.claude/skills" && \
git clone https://github.com/alik-git/update-remote-codex.git "$HOME/.agents/skills/update-remote-codex" && \
ln -s "$HOME/.agents/skills/update-remote-codex" "$HOME/.claude/skills/update-remote-codex"
```

Codex discovers the clone through `~/.agents/skills/`. The link exposes the same
source to Claude. The skill will be available on the next turn.

Invoke it with `$update-remote-codex` and identify the intended remote host.
Review `SKILL.md` before use; an update request can require interrupting Codex.

For future updates, inspect `git status` in the clone first and preserve local
changes. With a clean working tree, use `git pull --ff-only`, then review the
updated instructions.
