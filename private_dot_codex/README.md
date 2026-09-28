# Codex settings

For click → Chrome and ⌘-click → the in-app browser:

- Make Chrome the macOS default browser.
- In the app, set **Web URL and link open destination** to **Default browser**
  (and **Local URL open destination** if desired).
- Leave **Open web link in default browser** under keyboard shortcuts **Unassigned**.

Chezmoi leaves these app preferences alone. `modify_private_config.toml` updates
our other shared settings without replacing the rest of `config.toml`.
