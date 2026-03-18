# NAS Bootstrap Notes

This folder keeps reference material for setting up the personal NAS mount on machines where you want it. It is tracked in Git, but it is not a chezmoi-managed home-directory target.

The original setup was for a Synology share exposed at `//tank.local/tank/MyStuff` and mounted at `/mnt/MyStuff`. The included files are intended as reference and starting points, not as a blindly applied setup.

Contents:

- `mnt-MyStuff.mount`: systemd mount unit for the CIFS share.
- `mnt-MyStuff.automount`: matching automount unit.
- `nas_daemon_commands.sh`: helper commands to reload systemd and enable/start the units.
- `nas_creds_example`: example credentials-file format only. Do not commit a real credentials file.

Important notes before using this on a machine:

1. Review the share path, mount point, username path, UID, and GID in `mnt-MyStuff.mount`.
2. Create a local credentials file outside Git and update the `credentials=` path accordingly.
3. Copy the units into `/etc/systemd/system/` only on machines where this NAS mount is actually wanted.
4. Treat this folder as bootstrap/reference material, not as something that `chezmoi apply` should automatically install.
