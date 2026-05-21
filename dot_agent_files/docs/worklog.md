# Worklog

Use `~/worklog` for durable cross-repo or substantial repo-adjacent work notes:
plans, investigations, code reviews, and general notes.

When the user says "make a note", create a `kind: note` file in `~/worklog`.
When the user asks for a plan, investigation, or code review note, use the
corresponding `plan`, `investigation`, or `codereview` kind.

Use `~/worklog/SCRATCH.md` for temporary commands, bulky output, rough working
notes, copied logs, and other scratch material.

Do not create worklog notes proactively unless asked. If the user asks for a
durable note and the scope, project, or slug is unclear, ask a short question
instead of inventing one.

## Paths

Default note path:

```text
~/worklog/<scope>/YYYY/MM/DD/HHMM--project--kind--slug.md
```

Example:

```text
~/worklog/personal/2026/05/21/1410--devpy--plan--editable-overlays.md
```

Rules:

- `scope`: broad area such as `personal` or another future scope.
- `project`: short repo-ish label such as `devpy`, `dotfiles`, or another
  personal project.
- `kind`: `plan`, `investigation`, `codereview`, or `note`.
- `slug`: short lowercase topic with hyphens.
- Use `YYYY/MM/DD` folders.
- Use `HHMM` 24-hour time in filenames for sorting.
- Use human-readable 12-hour ET time in frontmatter.

If the correct scope is unclear, ask the user instead of inventing one.

## Frontmatter

Use simple YAML frontmatter:

```yaml
---
kind: plan
status: open
created: "Thu, May 21, 2026, 2:10 PM ET"
project: devpy
links:
  - https://github.com/alik-git/devpy-runner
folders:
  - ~/Projects/devpy-runner
---
```

Allowed `kind` values:

- `plan`
- `investigation`
- `codereview`
- `note`

Allowed `status` values:

- `open`
- `done`

Keep `links` and `folders` as simple lists. Do not create typed fields such as
`pr`, `pr2`, `issue`, `wandb`, or `wandb2`.

## Templates

Use the templates in `~/worklog/_templates`:

- `plan.md`
- `investigation.md`
- `codereview.md`
- `note.md`

For code reviews, the `ali-code-review` skill is the source of truth for the
review body format. The worklog `codereview.md` template only provides
frontmatter and points back to that skill.

## Safety

Do not store secrets, credentials, API keys, private tokens, or sensitive data in
the worklog.
