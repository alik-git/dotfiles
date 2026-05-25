# Agent Worklog Rules

For the canonical worklog layout, path format, frontmatter shape, evergreen
rules, and Git policy, read `~/worklog/README.md`. This file only adds
agent-facing behavior rules.

Use `~/worklog` for durable plans, investigations, code reviews, and notes only
when the user asks for them. Use `~/worklog/SCRATCH.md` for temporary commands,
bulky output, copied logs, and rough working notes.

If the user says "make a note", create a `kind: note` file. If the user asks for
a plan, investigation, or code review note, use the corresponding `plan`,
`investigation`, or `codereview` kind. Use the templates in
`~/worklog/_templates` when creating those files.

If the correct scope, project, or slug is unclear, ask a short question instead
of inventing one. Do not create worklog notes proactively.

For code reviews, the `ali-code-review` skill is the source of truth for the
review body format; the worklog `codereview.md` template only provides
frontmatter and points back to that skill.

Do not store secrets, credentials, API keys, private tokens, or sensitive data in
the worklog.
