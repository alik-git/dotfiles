# AGENTS.md

Ali K's personal global `AGENTS.md`.

## Most Important Instructions

Do not store, commit, or push secrets, credentials, or other sensitive information.

If this file conflicts with the code or repo docs, trust the code and docs,
then update `AGENTS.md`.

When unsure, ask a short question or make the smallest reversible change. Do
not invent local workflow assumptions.

## Keep This File Minimal

This file is only for general instructions that apply across projects. Project-specific instructions belong in an `AGENTS.md` at the root of the relevant project or repository.

Example:
"This project uses the XYZ conda environment" belongs in that project's `AGENTS.md`.

"Use Miniconda for Python environments" belongs in this global `AGENTS.md`.

## Instructions

If some additional access or tools would help, ask for them. I will try to provide them unless there is a security, cost, or practical reason not to.

When working in an existing project, follow the project's or team's established conventions if they conflict with the instructions below.

- For files managed by chezmoi, edit the chezmoi source under `/home/ali/.local/share/chezmoi`, not the live file path. This especially applies to `.codex/AGENTS.md`, `.codex/config.toml`, `.codex/rules/default.rules`, and `.bashrc`.
- For chezmoi-managed files, always run `chezmoi diff` before `chezmoi apply`.
- Prefer instructions here to be persistent, cross-project, and non-obvious. Put repo-specific workflow, commands, and environment details in the repo's own `AGENTS.md`.

## Command Style

- When running Git commands in a repo, prefer `cd /path/to/repo && git ...` over `git -C /path/to/repo ...` wherever possible.
- When giving the user a command that spans multiple shell steps, chain them with `&&`. For readability, break long commands across lines with trailing `\` while keeping the `&&` chaining.
- When giving commands for the user to run, omit arguments that only restate current defaults unless there is a reason to show them explicitly.
- Never commit or push local-only scratchpad files such as `DEVLOG.md`, `SCRATCH.md`. If they are in git repos, hide them with a local-only ignore such as `.git/info/exclude`.

### Development Logs

- If a project has a `DEVLOG.md`, use it as a high-level catch-up aid for humans and agents.
- `DEVLOG.md` is local-only context, not a source of truth. If it disagrees with the code, trust the code and update the log.
- If a project has a local `SCRATCH.md`, use it for large temporary command blocks, diffs, tables, or other bulky scratch output that does not belong in `DEVLOG.md`.
- When adding to `DEVLOG.md` or `SCRATCH.md`, append to the end of the file by default unless there is a clear reason not to.
- After a substantial investigation, a major plan, or a topic shift, it is a good time to add a `DEVLOG.md` entry summarizing what was learned or done.
- Add timestamped entries in the format `## YYYY-MM-DD HH:MM - Title`.
- Each entry should include a 1-2 sentence summary, then optionally `Details:` with the most important context.
- Do not add commands to `DEVLOG.md`; put substantive command blocks and runnable commands in `SCRATCH.md` instead.

### Git

- Keep commits small and logically separate.
- If I say `p` it means `push`.
- If I ask you to push and there are uncommitted changes, commit and push.
- For large or complex changes, use a feature branch, split the work into multiple commits, and ask if you should open a draft pull request.
- For pull request guidelines, see `~/.agent_files/common/docs/pull_requests.md`.
- Use the Conventional Commits specification for commit messages:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

For example:

```
feat: allow provided config object to extend other configs
```

- Common types include `fix`, `feat`, `chore`, `docs`, `style`, `refactor`, `perf`, and `test`.

### Python

- Use Miniconda for Python environments.
- Prefer `pathlib` over `os` for path-related code.
- Use `tqdm` for long-running loops or processes.
- Organize code as a proper Python package unless there is a good reason not to.
