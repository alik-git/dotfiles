# Workspace reference

Available locations and tools, not a required task setup. Reuse an appropriate
checkout; a worktree is useful for isolation, and a workset groups worktrees
when a change spans repositories. No task registry or companion notes are needed.

## Locations

| Location | Typical contents |
| --- | --- |
| `~/Projects/repos/` | Existing clones and editable tool-install sources |
| `~/Projects/worksets/` | Related worktrees grouped by task |
| `~/Projects/local_data/` | Large datasets and shared local artifacts |
| `~/Projects/archive/` | Historical local work |
| `~/.local/share/chezmoi/` | Dotfiles source; private configuration is in `dotfiles_private/` |
| `~/.agent_files/local/docs/` | Private machine and service references, if installed |

These describe the existing layout; other checkouts or app-managed worktrees
are fine. Preserve checkouts and environments that active work relies on.

## Tools

| Tool | Useful for |
| --- | --- |
| `uv` | Python projects, virtual environments, and standalone CLI tools |
| `agent-chat-reader` | Searching and reading prior Codex/Claude conversations |
| `quick-status` (`qs`) | Combined repository, CI, or environment snapshots |
| `workset` | Grouping Git worktrees for a multi-repository task |
| `veneer` / Conda | Older environments or dependencies requiring a Conda base |
| `~/.agent_files/tooling/ai-scratch/bin/ai-python` | Ad hoc analysis, plotting, and media/bag inspection |

Use the repository's environment configuration. For new lightweight Python work,
uv is the usual starting point; veneer/Conda remain available for projects that
need them. A uv error alone is not a reason to migrate an existing environment.
The shared scratch environment is for temporary analysis, not project runtimes.

## Desktop and remote sessions

A window appears on the machine running the GUI. macOS uses its logged-in desktop
session; Linux remote GUIs depend on the target's display/session setup. Verify
the intended host and desktop when launching a viewer remotely; display variables
and screenshot commands are platform-specific.
