# Codex configuration ownership

Chezmoi manages the explicitly listed defaults in `modify_private_config.toml`.
Other keys, including model selection, trusted project paths, and desktop browser
preferences, belong to the application/user and pass through unchanged.

Browser preferences are set in the app. Applying dotfiles does not force either
browser choice or reset an existing preference. The modifier's permission and
MCP defaults are unchanged by this ownership cleanup.
