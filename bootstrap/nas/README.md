# NAS Bootstrap Notes

This folder keeps reference material for setting up the personal NAS mount on machines where it is wanted. It is tracked in Git, but it is not a chezmoi-managed home-directory target.

## Recommended Approach

Use a CIFS mount via `/etc/fstab` with `x-systemd.automount`.

This keeps the workflow simple:

- mount the NAS like a normal folder
- auto-mount on first access when the home LAN is available
- avoid blocking boot when the NAS is unavailable

## Private Details

For more details, including the optional Tailscale mount workflow, see `dotfiles_private/bootstrap/nas/README.private.md`.

## Setup Outline

1. Install `cifs-utils`.
2. Create a root-owned `600` credentials file.
3. Create the desired local mount point.
4. Add the desired `fstab` entry.
5. Run `systemctl daemon-reload` and access the mount point to trigger the automount.
 
Treat this folder as bootstrap/reference material, not as something that `chezmoi apply` should automatically install.
