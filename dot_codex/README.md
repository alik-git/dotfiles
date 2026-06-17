# Codex Notes

This folder holds the managed global Codex setup.

## Trust Paths

Codex may programmatically add trusted project paths to the live
`~/.codex/config.toml` on startup. That can make `chezmoi diff` look dirty even
when the chezmoi source is unchanged.

Treat those path entries as expected local state unless there is a reason to
manage them explicitly in the chezmoi source.
