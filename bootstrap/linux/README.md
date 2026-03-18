# Linux Bootstrap

This folder contains manual bootstrap helpers for setting up a new Linux machine. These files are tracked in the dotfiles repo, but they are not managed into `$HOME` by chezmoi and they are not run automatically by `chezmoi apply`.

Use this when you want a safe, explicit first-run setup step for a new machine.

Current scope:

- Install a small base set of Ubuntu/Debian packages if they are missing.
- Install Miniconda from the official latest installer if it is missing.
- Install `nvm` from the official `nvm-sh/nvm` repository if it is missing.

Usage:

```bash
bash bootstrap/linux/install-personal-base.sh
```

Behavior:

- The script checks what is already installed and skips anything already present.
- System package installation is attempted only when `apt-get` is available.
- If `sudo` is unavailable or not permitted, the script reports which apt packages are missing and continues with the user-level installs.
- Miniconda and `nvm` are installed only if they are not already present.
- The script prints a summary and exits non-zero if any requested step failed.

Notes:

- This is intentionally a manual bootstrap step, not a `chezmoi run_` script.
- Keeping it manual avoids surprising `sudo` prompts during normal `chezmoi apply`.
- Shell initialization for `conda` and `nvm` should be managed separately in the dotfiles if you decide you want that.
