# Workspace Setup

Generic machine/workspace layout and environment conventions. For the task
lifecycle (worklogs, worksets, companion notes, veneer), see `dev-workflow.md`.
For worklog conventions, see `worklog.md`.

Anything specific to a given machine — shared environment names, repo shorthand,
VM/cloud access — lives in that machine's private companion doc under
`~/.agent_files/local/docs/` (empty unless a private repo provides it).

If you are Ali K and have the private `dotfiles_private` repo applied, also read
the machine-local companion at
`~/.agent_files/local/docs/workspace-setup-private.md` for this machine's
specifics.

## Project layout

```text
~/Projects/
  repos/       stable/reference checkouts and global tool install sources
  worksets/    active development contexts with repo worktrees nested inside
  local_data/  large datasets, generated data, and shared local artifacts
  archive/     inactive or historical local work
```

The active unit is a **workset**: a directory holding one or more git worktrees
for a task, under `~/Projects/worksets/<...>/<repo-name>`.

- Do not do active task work in canonical checkouts under `~/Projects/repos`.
  Those are stable/reference copies and global tool install sources only.
- For edits, branches, investigations, and reviews, use an existing free
  workset or create a new one.
- Let the workflow tools create worksets (`worklogs new --workset` /
  `workset new`) so worklog and workset paths mirror each other. Do not
  hand-create numbered (`dev-1`) or freeform folders.
- Keep folder contents self-explanatory — branch name, `veneer.toml`, and git
  status should cover the normal case. No per-workset marker files or
  registries.

## Stable checkouts and tools

`~/Projects/repos/<repo>` holds stable/reference checkouts. Point global
`uv tool install` editable installs at these, not at active worksets.

Inspecting a canonical checkout is fine when it is the fastest source of facts;
switch to a workset before making edits.

Core tools (installed via `uv tool install`):

- `veneer-py` — Python env manager for conda-based repos (`veneer` command)
- `workset` — create isolated git-worktree worksets
- `worklogs` — create worklog plans, companion notes, and worksets
- `quick-status` (alias `qs`) — fast snapshot of repo, worktree, CI, and env
  state

## Python workflow

Repos with conda dependencies carry a committed, self-contained `veneer.toml`;
pure-Python repos are managed by uv directly. See `dev-workflow.md` for the full
veneer workflow. The shared conda env name for a given repo comes from that
machine's local doc or the repo's `veneer.toml` comment.

`notuv`, `devpy`, and the old `extends`/stack pattern are deprecated — use
`veneer`.

## GUI over SSH

GUI apps launched from an SSH shell usually need the machine's desktop X session
(for example an AnyDesk, VNC, or physical session):

- `DISPLAY` is commonly `:1`, but varies by machine.
- `XAUTHORITY` should usually be unset in the SSH shell.
- The desktop user may need to allow the SSH user, for example
  `xhost +si:localuser:<ssh-user>`.

If a GUI app fails with display, GLX, or window-creation errors, verify the
desktop session and display routing before treating it as an app bug.

Capture the visible desktop with:

```bash
DISPLAY=:1 env -u XAUTHORITY python3 -c "from PIL import ImageGrab; ImageGrab.grab().save('/tmp/screenshot.png')"
```

When creating or converting videos, default to H.264 unless a repo doc or the
user asks otherwise.

## SSH and Git

When a machine is used over SSH with agent forwarding and Git SSH stops working
in a long-lived shell, suspect a stale forwarded-agent socket before debugging
GitHub auth.

## Worklog scratch

Use `~/worklog/SCRATCH.md` for temporary commands, bulky output, and rough
working notes. For clickable local-file links there, prefer paths relative to
the scratch file, and also include a copyable terminal path in backticks using
`~` or `$HOME` — VS Code Remote can fail to open absolute home-directory
Markdown links. See `worklog.md` for the full worklog conventions.
