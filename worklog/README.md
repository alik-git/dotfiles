# Worklog

`~/worklog` is the default home for durable plans, investigations, code reviews,
general notes, and scratch output.

Durable entries use one of four kinds: `note`, `plan`, `investigation`, or
`codereview`.

Use `~/worklog/SCRATCH.md` for temporary commands, bulky output, and rough
working notes. `SCRATCH.md` is local-only and is intentionally not managed by
chezmoi.

## Layout

```text
~/worklog/
  README.md
  SCRATCH.md
  _templates/
    plan.md
    investigation.md
    codereview.md
    note.md

  personal/
    YYYY/
      MM/
        DD/
          HHMM--project--kind--slug.md

  evergreen/
    qstatus--overview.md
```

## Note Paths

Use:

```text
~/worklog/<scope>/YYYY/MM/DD/HHMM--project--kind--slug.md
```

Example:

```text
~/worklog/personal/2026/05/21/1410--devpy--plan--editable-overlays.md
```

Rules:

- `scope`: broad area, such as `personal` or another future scope.
- `project`: short repo-ish label, such as `devpy`, `dotfiles`, or another
  personal project.
- `kind`: `plan`, `investigation`, `codereview`, or `note`.
- `slug`: short lowercase topic with hyphens.
- Use `YYYY/MM/DD` folders.
- Use `HHMM` 24-hour time in filenames for sorting.
- Use human-readable 12-hour ET time in frontmatter.

## Frontmatter

Keep frontmatter simple:

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

Use simple `links` and `folders` lists. Do not create typed fields such as
`pr`, `pr2`, `issue`, `wandb`, or `wandb2`.

## Evergreen

Use `~/worklog/evergreen` only for short index notes. Keep it flat: no topic
subfolders and no detailed plans, investigations, reviews, artifacts, or scratch
files. Each evergreen note should be a brief overview file named like
`project--overview.md` with a short paragraph and links to dated worklog notes.

## Git

Do not make `~/worklog` a Git repo by default. If a scope later needs version
control, make that scope its own private repo.
