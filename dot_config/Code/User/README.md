# VS Code config

- `settings.json`: live VS Code user settings managed by chezmoi.
- `keybindings.json`: live VS Code user keybindings managed by chezmoi.
- `extensions-manifest.txt`: tracked list of desired extensions for reference/reinstall; VS Code does not read this file directly.

Workflow:
- Make changes in VS Code or by editing these files directly.
- Treat chezmoi as the source of truth, even though VS Code Settings Sync is still enabled.
- Be careful. Check `chezmoi diff` before `chezmoi apply`, since Settings Sync may introduce temporary drift.
- Review diffs in chezmoi and keep the config curated over time.
