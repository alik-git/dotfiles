# AGENTS.md

Ali Kuwajerwala's personal global `AGENTS.md`.

## Most Important Instruction

Do not store secrets, credentials, or other sensitive information in this file. This repository is currently private on GitHub, but it may become public in the future, so treat it as if it were public.
The same applies to every other file in this repository. Never add or commit secrets or other compromising information anywhere in it.

## Command Style

When running Git commands in a repo, prefer `cd /path/to/repo && git ...` over `git -C /path/to/repo ...` wherever possible.

## Keep This File Minimal

This file is only for general instructions that apply across projects. Project-specific instructions belong in an `AGENTS.md` at the root of the relevant project or repository.

Example:
"This project uses the XYZ conda environment" belongs in that project's `AGENTS.md`.

"Use Miniconda for Python environments" belongs in this global `AGENTS.md`.

## Instructions

If some additional access or tools would help you work better, faster, or more easily, don't hesitate to ask me for it. As long as there is no security, cost, or other practical constraint, I will try to provide it.

When working in an existing project, follow the project's or team's established conventions if they conflict with the instructions below.

### Development Logs

- If a project has a `DEVLOG.md`, use it as a high-level catch-up aid for humans and agents.
- `DEVLOG.md` is local-only context, not a source of truth. Do not commit it. Add it to `.gitignore` if needed. If it disagrees with the code, trust the code and update the log.
- After a substantial investigation, a major plan, or a topic shift, it is a good time to add a `DEVLOG.md` entry summarizing what was learned or done.
- Add timestamped entries in the format `## YYYY-MM-DD HH:MM - Title`.
- Each entry should include a 1-2 sentence summary, then `Details:` with a flat bullet list of the most important context.
- When adding commands to a dev log, prefer normal Markdown command formatting over bullets so the commands are easy to copy-paste.

Here are two examples so the format is clear:
```markdown
## 2026-03-14 16:31 - Workflow cache fix
Added `requirements.txt` with `nbconvert` so the new `actions/setup-python` cache step has the dependency file it expects.

## 2026-03-14 20:05 - Temporary fast local preview setup
Used a temporary local-only fast-preview override while editing the migration branch so previews for changes would rebuild faster.
Details:
- Disabled ImageMagick and excluded the notebook-heavy `visuallearn` post only in a temporary override config used for local preview.
- This was not a committed repo change and was restored to match full site config after edits were finalized.
```

### Git

- Prefer `cd /path/to/repo && git ...` over `git -C /path/to/repo ...` wherever possible.
- Keep commits small and logically separate.
- If I say `p`, treat that as shorthand for `push`.
- If I ask you to push and there are uncommitted changes, treat that as shorthand for commit and push.
- For large or complex changes, use a feature branch with multiple commits and open a PR.
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
- For long-running loops or processes, use `tqdm` so progress is visible.
- Organize code as a proper Python package unless there is a good reason not to, such as working in an existing project that already follows a different structure.
